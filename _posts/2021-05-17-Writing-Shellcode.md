title:  "Writing Shellcode"
date:   2021-05-17 23:00:00 +0000
header:
  overlay_image: /assets/images/posts/shellcoding/banner.png
  teaser: /assets/images/posts/shellcoding/banner.png
excerpt: "My workflow for shellcode challenges."
categories:
  - Technical
tags:
  - CTF
  - Exploit Developmentn

---

Working on the [pwn.college](http://pwn.college) shellcoding challenges has been great. I've come across shellcode before in various pieces of exploit development training, but it's always been an overview - 'this is how shellcode is written, don't worry, it's not really a thing so much anymore'. Well, I exxagerate, but you get the idea, there's lots of tooling and existing shellcode out there and I've got away with relying on that almost entirely. Until now...

The [pwn.college](http://pwn.college) shellcode challenges execute input you provide and are written to make any other type of exploit difficult. This forces you to write an tailor shellcode and to be honest - it's been a lot of fun.

I should note that the focus of this training is almost entirely Linux, Windows shellcode is even more of a mystery to me, but I feel inspired to check it out now. 

# Tools for the job

I've previously compiled what little shellcode I've written using nasm, with something like:

```bash
~$ nasm shellcode.s -o shellcode.out
~$ xxd -ps shellcode.out
\x90\x90\x90\x90
```

But the [pwn.college](http://pwn.college) guys suggest gcc, which is really nice, because we also get the shellcode as a pre-wrapped ELF, so no messing round with shellcode invoking C binaries, joy! I wrapped this in a small bash script:

```powershell
#!/bin/bash

if [ "$1" = "" ]
    then 
        echo "Usage : $0 shellcode_file.s"
        exit
    else
        # gcc -static -nostdlib $1 -o $1.elf  
        gcc -Wl,-N --static -nostdlib $1 -o $1.elf # Makes .text RWX - beats above
        objcopy --dump-section .text=$1.raw $1.elf
fi
```

This will turn `shellcode.s` into `shellcode.s.raw` - raw bytes you can pipe to a binary (or whatever), and `shellcode.s.elf`, a binary you can just run or debug in GDB to test your shellcode.

# Shellcode Modification Workflow

As you work through the challenges, various issues will be thrown at you and whilst the excellent lecture material that accompanies the challenges does tell you how to work around these, I wanted to explain some of my mistakes and the process I found helpful.

## Worked Example

Bad bytes are a real and common thing with shellcode, taking an example of some basic code to `execve /bin/sh` :

```bash
~$ cat pop_shell.s
.global _start
_start:
.intel_syntax noprefix
    mov rax, 0x35                  # syscall number of execve (59) goes in rax
    mov rbx, 0x0068732f6e69622f    # move "/bin/sh\0" into rbx
    push rbx                       # push "/bin/sh\0" onto the stack
    mov rdi, rsp                   # point rdi at the string on stack (arg 1 to execve)
    mov rsi, 0                     # makes the second argument, argv, NULL
    mov rdx, 0                     # makes the third argument, envp, NULL
    syscall                        # trigger the system call
```

Now if we load this into a program that filters null bytes our shellcode will be affected, if we look at the raw shellcode bytes with `xxd` we see it's full of null bytes:

```bash
~$ ./compile_shellcode.sh pop_shell.s
~$ xxd -g 1 pop_shell.s.raw
00000000: 48 c7 c0 3b **00 00 00** 48 bb 2f 62 69 6e 2f 73 68  H..;...H./bin/sh
00000010: **00** 53 48 89 e7 48 c7 c6 **00 00 00 00** 48 c7 c2 **00**  .SH..H......H...
00000020: **00 00 00** 0f 05
```

So if we have these 'bad bytes', how do we work it through? I follow a simple process:

1. Visualise where the bad bytes are in the shellcode
2. Understand which part of the instructions they're in
3. Enumerate alternatives
4. Select best option (this becomes important as other constraints come in, e.g. length).

So let's do it:

### Visualise bad bytes

Because we created an ELF when we compiled, we can get nice disassembly of the shellcode with tools like `objdump`:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled.png)

In this image, we can see that the null bytes are introduced in four of our lines of assembly - when we mov 0x3b into rax (1), when we mov the string into rbx (2), when we mov 0x0 into rsi (3) and when we mov 0x0 into rdx (4).

### Understand why bad-bytes are there

Knowing which instructions give rise to our bad bytes, let's understand why; I'll start at the start with `mov rax, 0x3b` which is moving the syscall number into rax. TO understand why there are nulls here, let's add some extra instructions:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%201.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%201.png)

Now after we do the rax move, we move the same value with leading 0s into rax (1), then we move the same value into the lower 32 bits of rax (2), then the lower 16 bits (3) and finally the lower 8 bits of rax (4). Viewing the disassembly we see the corresponding opcodes:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%202.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%202.png)

1. The leading 0s version is exactly the same set of opcodes, this is because when we say `mov rax, 0x3b` what we're really telling our assembler is to zero out the rest of the register - so the first two lines are the same instruction, just written differently in our shellcode source. Now you might expect there to be 7 null bytes - one for each spare byte in the 64 bit rax register- the reason there aren't more 0s for the rax moves that on amd64 architecture, zeroing out eax also zeros our rax, it's just the way it is, so we only need to send the three extra null bytes.
2. The eax version (2) actually includes the same number of 0s (but fewer opcodes to define the operation and register),,the upshot of this is that you dont need any more 0s in your bytecode to clear rax than eax. 
3. As we go to smaller registers (this time ax - 16 bits) we see that there's only one spare null byte now, one byte for each null needed to clear the rest of ax.
4. Finally, moving a single byte into al doesn't include any null bytes at all, because the value and register are the same size.

To further visualise this, we can use [rappel](https://github.com/yrp604/rappel) to emulate 64 bit registers and see the opcodes working, first we'll place all fs in rax so we can see any zeroing taking place:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%203.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%203.png)

Now we can see our mov instruction in action:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%204.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%204.png)

Now we can verify that doing the same with eax has the same effect:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%205.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%205.png)

Bingo! Now going down the smaller registers:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%206.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%206.png)

We see that the higher bits are left well alone. This is important for us in shellcode land, because when we make a syscall, rax is passed to the kernel and any junk left in those registers might lead to unwanted behaviour.

### Enumerate Alternatives

Now we know why we have bad bytes, I like to enumerate alternative instructions. I use an arduous manual process that basically involves having an editor window and a terminal window opening, adding and instruction, compiling and checking the resultant bytes for nulls.

Taking this approach for our first instruction in pop_shell.s, I know that moving a small number into rax leads to nulls, but a small one into al doesn't. This is good, but I also need to keep the most significant bits in rax clean, by zeroing them out. 

Now if we knew for sure what state rax would be in, we could subtract that value from rax, but this isn't very portable. We could move 0x00 in from another register if we know that's definately zerod, but that's the same portability issue. 

I'm afraid I'm going to cheat, because I already know that XOR-ing a register with itself will zero it out without any null bytes, so I'll comment out our bad shellcode (1) and replace it by trying to zero the register with an XOR (2), then move 0x3b into al (3), hopefully avoiding nulls:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%207.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%207.png)

Compile and test:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%208.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%208.png)

Amazing! Now we know this works, but we could continue enumerating options, for example, I said before xoring eax and eax also zeros out rax:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%209.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%209.png)

This actually comes in one byte shorter, so I'm going to select that. 

Now with my option selected, I'm free to move on to the next instructions.

## Finishing our no-nulls shellcode

We know that the mov instructions into rsi and rdx are also zeroing out registers, so I'll leave it to the reader to remove those nulls, but what about us moving our string into rbx? That's difficult, because we need that string to be null terminated, so what other alternative are available to us before we select one? Luckily the lecture material covers this big time, what we can do there is zero out our register, then load part of the string into eax. Once this part is there, we can bit-shift the string left and fill the empty bits with the rest. Let's see it in rappel again:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2010.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2010.png)

Here we load ebx full of most of the string (1), bit shift the register left, to make room to load ax up (eax or higher would zero out the register again) (2), then load another 2 bytes in (3), shift left one more time (4) and load in the last byte(5). 

This is a viable option, but we have another option:

```bash
# remove the null byte from the string and then re-instate it with math:
mov rbx, 0xff68732f6e69622f         # push '/bin/sh\xff' onto the stack
push rbx                            # Push the value on to the stack
inc BYTE PTR [rsp + 0x7]            # Add 0x01 to the 0xff stored on the stack
```

I find this a bit neater and shorter, so I'm going with that. Depending on the string and PATH variables, you might get away with shortening a string to 4 bytes and pushing it, or moving it into a register that's the same size (e.g. `mov al, 0x6873 # "sh"`). Mess with it.

# Other shellcode tricks

The lectures cover this really well, but don't really expand on how some of the tips work, here's some in action:

## Self modifying shellcode

You'll need your memory to be RWX where your shellcode is loaded, let's start simple, with an xor to clear eax:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2011.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2011.png)

Let's imagine that 0x31 was a bad byte, so we can instead have raw shellcode bytes `\xc0\x30` (because little endian) and increment the first byte on the fly (also note the first instruction is a nop, for some reason having an inc as the first instruction in the compiled ELF file doesn't run right):

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2012.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2012.png)

So we start with the increment instruction, then write the raw shellcode bytes in. We can watch this in gdb by running `gdb ./pop_shell_demo.s.elf` and breaking at _start:

![Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2013.png](Shellcode%20Writing%206968d7b9f2234368ae71a3b334d5a40b/Untitled%2013.png)

Now breaking at start (1), we can carry out the first nop (2) (needed to effectively write to RIP for some reason when running the standalone shellcode ELF), then we're at the inc BYTE PTR instruction (3) - note that rip will actually point to _start + 0x7, becuase RIP will advance on this instruction. Finally, our instruction has been modified, yay!

## Read more shellcode in

If you're tight on space, you can read shellcode in as a second stage from stdin. This involves makind [a read syscall,](https://filippo.io/linux-syscall-table/) placing the right data in registers to call read:

```bash
.global _start
_start:
.intel_syntax noprefix
        # Read syscall 
        # put fd in rdi - 0 for stin
        # put read location in rsi
        # put read count in rdx 
    # Syscall number - 0 in rax

    xor edi, edi                # Set edi to zero - fd for stin
    mov rsi, 0x0102030405060708 # Pointer to RWX memory for stage 2 shellcode
    mov rdx, 0x1000             # read 0x1000 bytes - usualy memory page size IDK
    xor eax, eax                # Read syscall number is zero
    syscall

    jmp rsi                     # Execute that shellcode!
```

Your memory location must be rwx and it's a good idea to include some NOPs for a safe landing.

### Do something unexpected

If you're struggling (I did on the very short shellcode challenges) consider these tips:

1. If space restricted, check if register values are predictable for the challenge in question - you could remove some zeroing operations, or even use data already in registers.
2. Try [other syscalls](https://filippo.io/linux-syscall-table/), for challenges with flags, why not mess with the file permissions?
3. Use junk opcodes - if you've got sorted or mangeld shellcode, you could always insert junk commands (increment a register you're not using, add some values) to bypass a filter.---
defaults:
  # _posts
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      read_time: true
      comments: false
      share: true
      related: true
title:  "Managing Passwords"
date:   2020-04-30 23:00:00 +0000
header:
  overlay_image: /assets/images/posts/password_level_2/arcade.jpeg
  teaser: /assets/images/posts/password_level_2/arcade.jpeg
excerpt: "Cyber self defence - Level 2."
categories:
  - Security guidance
  - Threats & Risk
tags:
  - Passwords
  - Two Factor Authentication
  - Password Managers
  - Account Security
feature_row1:
  - image_path: /assets/images/posts/password_level_2/keepassxc.png
    excerpt: "**KeePassXC** is a Free Open Source implementation of KeePass, available on most platforms and devices. Mobile equivalents are available from various sources."
    url: https://keepassxc.org/
    btn_label: "Check out KeePassXC"
    btn_class: "btn--inverse"
feature_row2:
  - image_path: /assets/images/posts/password_level_2/lastpass.png
    excerpt: "**LastPass** is a Freemium password manager, meaning basic accounts are free, advanced features are not. It's available on most platforms and devices via browser extensions or official Apps."
    url: https://lastpass.com/
    btn_label: "Check out LastPass"
    btn_class: "btn--inverse"

---

# Ready Player One

In [Level 1](/security guidance/threats & risk/Password-Fu-Level-1/){:target="_blank"}, we covered the importance of strong passwords and created a **super passphrase** for your personal use. Now you've levelled up from manual password creation and you're ready to make some changes to your accounts.

## Level Outline

In this level, you'll be using your **super passphrase** to protect the rest of your accounts. How? Using a **password manager**.

**TL;DR** - Use a password manager (seriously.) and migrate your accounts to it over time.

## Why do I need one a password manager?

If you take one thing away from this post, let it be that a personal Password Manager will make your life easier ane your accunts more secure.

![What is a password manager?](/assets/images/posts/password_level_2/Kirk_what.gif)

A Password Manager stores credentials for all your accounts, then locks them away with a single password; the manager acts as your personal login assistant and when it comes to passwords, they tend to be much smarter than we are.

{% include figure image_path="/assets/images/posts/password_level_2/jeeves.gif" alt="Your personal assistant is a password genius" caption="Warning! Your password manager may be better at this than you; get used to it seeming to say *'Indeeeeed, Sir.'*." %}

# Isn't this putting my eggs in one basket?

People often ask me if a password manager isn't just making a jucier target for attackers. It's true, your data is in one place, but this line of thinking doesn't consider the mechanisms that sting everyday people, or the likelihood of something bad happening. Just like how a bank collecting everyone's money together might seem like creating a juicy target, it can still be safer for you as an individual than keeping it under the mattress, because in modern society, bank robberies are relatively rare.

In [Part 1](security guidance/threats & risk/Lets-Talk-Passwords/){:target="_blank"} we discussed data breaches and people guessing passwords; most 'normal' users (i.e. readers of this post) are more likely to be involved in a public data breach, or have a bad password guessed than be subject to a password manager attack on their personal machine.

If you're still not convinced, let's follow the one-basket argument to its conclusion - a password manager running on your machine is compromised, the attacker has access to all your accounts, game over, password manager bad, right? Well let't take the password manager away, the attacker has access to your machine again, are you better off now? I don't think so. This attaker still might be able to see what you type (including passwords), prompt you for your passwords on-screen, or take advantage of any current logged in sessions you have to your email, social media, bank etc.

The scenarios may differ from person to person, but generally, I believe that the security detriments of password managers are overplayed. For most people, access to your email gets you access to everything else; if you protect your password manager as well as (and if you keep reading, maybe better than!) your email, for most people it will only increase your security.

# How do they work?

In [Part 1](security guidance/threats & risk/Lets-Talk-Passwords/){:target="_blank"} of this series, we discussed how passwords are attacked; our password manager is going to fix almost all of the issues we discussed there by making our passwords unique and **very** hard to guess. The best part? This actually comes at *less* mental load than remembering a few unique passwords, freeing your mind to concentrate on, well, anything else!

Password managers are bascially a big store for data, you type the usernames, passwords, notes etc. for a given account and the password manager [encrypts](https://en.wikipedia.org/wiki/Encryption){:target="_blank"} them, so they can't be read until the data store is unlocked; the analogy of a vault isn't a bad one, you use your combination (the main password) to unlock the vault and then you can copy all your stuff out; the main weakness with these is that, when the vault is open, it's weaker to being compromised by [malware](https://en.wikipedia.org/wiki/Malware){:target="_blank"} and bad guys, so it's good practice to keep it as locked up as is useable for you.

There are two main camps in password manager selection - **online** and **offline**. Offline managers are simple - a bit of software runs on your PC, phone, wherever and a password file stores your data; everything is in your control, **including responsibility for looking after that file**. Online managers look after that file for you, often using zero-knowledge encryption, meaning that the file is only decrypted locally on your logged in machines; these often have fancy features too, such as one-click site-launchers that log you all the way in to a site instantly, automatic password changers for most big sites, and clever integration with major browsers.

For a simple rule of thumb, read the following - Offline managers tend to be more secure, but are only as good as the security (including solid backups!) of your device and passwords file. Online managers are considered less secure because they can be attacked remotely (though vendors have good protections against this), and because it's possible for there to be a data breach via that vendor that you can't control. For most people, I think this is still better than nothing and with the right provider and good main password, security shouldn't be a problem for most users.

## Can't my browser do this?

Yes, but don't! Most modern browsers have this capability, but it usually comes with fewer security features (zero-knowledge encryption and additional authentication factors), and/or doesn't allow Syncing across devices.

If that doesn't deter you, these browser managers are much more likely to be attacked by malware; there are well known tools, with low barriers to entry that will pull browser stored credentials during basic scanning of a system, so I always reccomend to use a dedicated product.

# How do I set one up?

## Offline Managers

I find offline managers really easy to set up; I like KeePassXC, because it's available on all sorts of devices and it just... works.

{% include feature_row id="feature_row1" type="left" %}

If you think offline is your thing, you can get up and running as follows:
  1. Download and install KeePassXC, or install via any app store or repository you normally use.
  1. Create a new Database; your main passphrase from [Level 1](/security guidance/threats & risk/Password-Fu-Level-1/){:target="_blank"} will come in handy here!
  1. Consider using a key-file or second factor, if you think you can manage this.
  1. Hit 'add account' and populate your first entry; why not start by just entering your main email account details, changing the password while you're at it; nothing more unless you're really feeling it!
  1. Back up your database at once!

{% include figure image_path="/assets/images/posts/password_level_2/backup.gif" alt="Backup reminder" caption="Sh*t happens and your disks aren't going to protect themselves." %}

Now, KeePassXC is free (in every sense) and open source; if you like projects like this, donating is always a good idea.

{% include figure image_path="/assets/images/posts/password_level_2/be_excellent.gif" alt="Why not donate?" caption=" " %}

### What was that about a key-file?

Key files and second factors are supported in KeePassXC; these are extra login steps you can add, which, in my view, don't add that much security when you're using the software in the context of your device, but adds some worthwhile protection for your password file if you lose a backup disk, for example. A Key file is a normal file that the software must read to unlock your Database (KeePassXC can also generate these); by leaving this file on your device and moving the Database around, you should never lose both at the same time, making attacking a lost Database much harder.

## Online Managers

Online managers aren't much harder to set up than an offline manager, they just include a registration step, which is usually pretty simple; you can use your super secure password from [Level 1](/security guidance/threats & risk/Password-Fu-Level-1/){:target="_blank"} again here.

I have friends that have success with [LastPass](https://lastpass.com){:target="_blank"}, [Dashlane](https://dashlane.com){:target="_blank"} and [1password](https://1password.com){:target="_blank"}. Most provide good protection and there are plenty of reviews you can look at online; for this walkthrough, I'm going to cynically assume we want to do this on the cheap and so we'll go with LastPass.

{% include feature_row id="feature_row2" type="right" %}

The generic steps for setting online managers up are as follows; you can use these steps to set up your LastPass manager if you think an online manager is the way to go for you:
  1. Download the application from the vendor site, app store etc. or get the browser extension for your broswer of choice (**cough** Firefox).
  1. Sign up for an acount, using your mega passphrase from [Level 1](/security guidance/threats & risk/Password-Fu-Level-1/){:target="_blank"}.
  1. Once your acount is activated, sign in and orientate yourself.
  1. Click the button to add an acocunt or site and start with your main email account; enter the details, changing the password while you're at it; nothing more unless you're really feeling it!

# Now what?

I hope you're a password manager convert! That wasn't so hard, was it?

{% include figure image_path="/assets/images/posts/password_level_2/seen_the_light.gif" alt="Now you've seen the light!" caption="" %}

You  might be wondering why we didn't change all your passwords; I actually don't recommend this at first, security is a marathon, take your time. When an account password needs changing, add it to your manager; along side that, change accounts at a pace that suits you, starting with most serious - main email, banking, personal accounts, any IOS or Microsoft accounts. Do it over time.

Another vital step now is to log out of everything and log back in; get that super password memorised, or store a backup safely as we discussed in the password blog series [Level 1](/security guidance/threats & risk/Password-Fu-Level-1/){:target="_blank"}.

You might have noticed me mention 'factors of authentication' throughout this post; if this is something you're unsure about, or a foreign term to you, you're in luck! Our next post will be your password-fu black belt, taking your account security to new heights. See you there.
