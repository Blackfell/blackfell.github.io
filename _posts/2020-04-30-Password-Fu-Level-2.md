---
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
  - Guidance
  - Threats
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
  - image_path: /assets/images/posts/password_level_2/bitwarden.jpg
    excerpt: "**BitWarden** is a Freemium Open Source password manager, meaning basic accounts are free, advanced features are not. It's available on most platforms and devices via browser extensions or official Apps."
    url: https://bitwarden.com/
    btn_label: "Check out BitWarden"
    btn_class: "btn--inverse"

---

# Ready Player One

In [Level 1](/guidance/threats/Password-Fu-Level-1/){:target="_blank"}, we covered the importance of strong passwords and created a **super passphrase** for your personal use. Now you've levelled up from manual password creation and you're ready to make some changes to your accounts.

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

In [Part 1](guidance/threats/Lets-Talk-Passwords/){:target="_blank"} we discussed data breaches and people guessing passwords; most 'normal' users (i.e. readers of this post) are more likely to be involved in a public data breach, or have a bad password guessed than be subject to a password manager attack on their personal machine.

If you're still not convinced, let's follow the one-basket argument to its conclusion - a password manager running on your machine is compromised, the attacker has access to all your accounts, game over, password manager bad, right? Well let't take the password manager away, the attacker has access to your machine again, are you better off now? I don't think so. This attaker still might be able to see what you type (including passwords), prompt you for your passwords on-screen, or take advantage of any current logged in sessions you have to your email, social media, bank etc.

The scenarios may differ from person to person, but generally, I believe that the security detriments of password managers are overplayed. For most people, access to your email gets you access to everything else; if you protect your password manager as well as (and if you keep reading, maybe better than!) your email, for most people it will only increase your security.

# How do they work?

In [Part 1](guidance/threats/Lets-Talk-Passwords/){:target="_blank"} of this series, we discussed how passwords are attacked; our password manager is going to fix almost all of the issues we discussed there by making our passwords unique and **very** hard to guess. The best part? This actually comes at *less* mental load than remembering a few unique passwords, freeing your mind to concentrate on, well, anything else!

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
  1. Create a new Database; your main passphrase from [Level 1](/guidance/threats/Password-Fu-Level-1/){:target="_blank"} will come in handy here!
  1. Consider using a key-file or second factor, if you think you can manage this.
  1. Hit 'add account' and populate your first entry; why not start by just entering your main email account details, changing the password while you're at it; nothing more unless you're really feeling it!
  1. Back up your database at once!

{% include figure image_path="/assets/images/posts/password_level_2/backup.gif" alt="Backup reminder" caption="Sh*t happens and your disks aren't going to protect themselves." %}

Now, KeePassXC is free (in every sense) and open source; if you like projects like this, donating is always a good idea.

{% include figure image_path="/assets/images/posts/password_level_2/be_excellent.gif" alt="Why not donate?" caption=" " %}

### What was that about a key-file?

Key files and second factors are supported in KeePassXC; these are extra login steps you can add, which, in my view, don't add that much security when you're using the software in the context of your device, but adds some worthwhile protection for your password file if you lose a backup disk, for example. A Key file is a normal file that the software must read to unlock your Database (KeePassXC can also generate these); by leaving this file on your device and moving the Database around, you should never lose both at the same time, making attacking a lost Database much harder.

## Online Managers

Online managers aren't much harder to set up than an offline manager, they just include a registration step, which is usually pretty simple; you can use your super secure password from [Level 1](/guidance/threats/Password-Fu-Level-1/){:target="_blank"} again here.

I have friends that have success with [BitWarden](https://bitwarden.com/){:target="_blank"}, [Dashlane](https://dashlane.com){:target="_blank"} and [1password](https://1password.com){:target="_blank"}. Most provide good protection and there are plenty of reviews you can look at online; for this walkthrough, I'm going to cynically assume we want to do this on the cheap and so we'll go with BitWarden, which also happens to be highly functional and open source.

{% include feature_row id="feature_row2" type="right" %}

The generic steps for setting online managers up are as follows; you can use these steps to set up your BitWarden manager if you think an online manager is the way to go for you:
  1. Download the application from the vendor site, app store etc. or get the browser extension for your broswer of choice (**cough** Firefox).
  1. Sign up for an acount, using your mega passphrase from [Level 1](/guidance/threats/Password-Fu-Level-1/){:target="_blank"}.
  1. Once your acount is activated, sign in and orientate yourself.
  1. Click the button to add an acocunt or site and start with your main email account; enter the details, changing the password while you're at it; nothing more unless you're really feeling it!

# Now what?

I hope you're a password manager convert! That wasn't so hard, was it?

{% include figure image_path="/assets/images/posts/password_level_2/seen_the_light.gif" alt="Now you've seen the light!" caption="" %}

You  might be wondering why we didn't change all your passwords; I actually don't recommend this at first, security is a marathon, take your time. When an account password needs changing, add it to your manager; along side that, change accounts at a pace that suits you, starting with most serious - main email, banking, personal accounts, any IOS or Microsoft accounts. Do it over time.

Another vital step now is to log out of your password manager and log back in, you're relying on access to this manager now, so make sure your account isn't going to be forgotten. Get that super password memorised, or store a backup safely as we discussed in the password blog series [Level 1](/guidance/threats/Password-Fu-Level-1/){:target="_blank"}.

You might have noticed me mention 'factors of authentication' throughout this post; if this is something you're unsure about, or a foreign term to you, you're in luck! Our next post will be your password-fu black belt, taking your account security to new heights. See you there.
