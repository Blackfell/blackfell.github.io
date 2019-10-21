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
title:  "Point Dexter's Lab"
date:   2019-10-10 21:00:00 +0000
header:
  overlay_image: /assets/images/posts/hacking_lab/rock_paper_scissors.jpeg
  teaser: /assets/images/posts/hacking_lab/rock_paper_scissors.jpeg
excerpt: "Why you need a lab and how to build one."
categories:
  - Technical Guidance
  - Labs & Hacking
tags:
  - Lab
  - Virtual Machines
  - Windows
  - Linux
  - Hacking
toc: true
toc_sticky: true
toc_label: "What's in this post?"
toc_icon: "arrow-circle-down"


---

# Point Dexter's Lab

In the [last post]() we discussed how to start your security learning journey. Hopefully you have an idea of what you'd like to learn, now lets get down to doing it.

# It's lab time

Now that you've got an overview of how why adn how you might use a lab, let's cut to the good bit, making it; to some people, a lab feels like a blocker, but I try adn see buiilding it as a chance to learn and hone skillz.

## What will we build then?

I'm going to walk though building a virtual lab in this tutorial; I'm going to use wholly free software and install some basic virtual machines to play with. This is just an example though, your lab can look however you want; I'll discuss paid software and options that don't require virtualisation (i.e. using physical hardware). you are free to substitute paid software and/or bare metal machines wherever you like.

### what is ths Virtualisation anyway?

Virtualisation is a large topic ([Wikipedia](https://en.wikipedia.org/wiki/Virtualization) may help here), but what I mean here is the use of Virtual Machines for you to play with. Virtual Machines are like a normal computer, but they aren't tied to any hardware; the simple explanation, is that they run like a computer within a computer.

Why bother? Well VMs allow you to run more than one operating system on a single 'host' machine.

![Virtualisation]()

This is useful to you for many reasons, not only can you have attacker machines, victims and malware analysis machines all running on one host, you also get to get them to talk to each other over a virtual network, meaning you can separate them from each otehr and the host. VMs are usually stored on the host machine and can be very easily backed up and restored, a huge win if you're into malware analysis or crashing victim machines!

There are downsides to Virtualisation though; the only one you really need to think about is performance, you'll need good hardware to virtualise an attacker and a victim machine at the same time. So how much is enough? Well if you have around 8GB of RAM and a reasonable (~i5 in Intel speak), you can probably manage a virtual lab of one attacker (with a couple og GB RAM) and a low-resource victim like those I'll describe later##.

I will note aswell, that the segregation between VMs is not as strong as having separate physical machines; VMs can be escaped by certain exploits, but these are rare and expensive, this isn't considered an issue for 'normal use' because you're probably not worth it (sorry!).

### Chosen architecture

The lab I'm building would look like this if I made it of physical machines adn networking gear:

![lab diagram]()

I have some networks, I have some hosts and I can connect them together however I like; the machines in question are varied, there area attacker machines adn some victims, but if I wanted to learn about Windows, my lab might look like this:

![Windows AD Lab]()

It's up to you! They way it's built, we can plug and unplug machines as we want to learn different things. My lab witl use virtual machines though, so we can really mess with the configuration here. If I remove the physical diagram and turn it into a virtual diagram, it now looks like this:

!][Virtual version of the diag]()

Which looks a lot simpler, in fact, now it's only one machine. So let's get started.


# Down to design

Let's do some actual config then.

## Picking hardware

How you build your lab can depend on what hardware you have adn whetehr you can afford to splash on some new gear. It's late 2019 now, so if you have anything less than 8GB or RAM and an Intel i5 processor, you may find that you struggle virtualising this simple lab on a single machine.

Generally, RAM is an important requirement for us virtualising our lab; the VMs we use will be 'stealing' RAM from teh host machine, so by the time you're running a 4G RAM attacker and a 1G victim, you're only got 3 left for your host system. That said, VMs will use all teh resources of the machine, oprocessing power is important and whilst you can deal with removable media for storing VMs, a good amount of storage will make life easier. Dedicated graphics isn't a hard requirement, but will make your experience a little smoother, spend on this last.

At  this point, you'll probably have to decide whether your lab will be portable, or in some static hardware. Portable labs (i.e. laptops) are great for taking to training venues, conferences and *cough* on holiday. If you do pick a laptop and are looking to buy something, I like to spec up the non-upgradeable components, but buy something where RAM and storage (at the very least) can be upgraded. Practically, this means that if you have a choise of, say, i5 vs i7 with 8 and 16 G of RAM respectively, go with teh better processor with a view to upgrading RAM if you need. This is all standard PC buying stuff, thought a different lens.

Whatever you pick, check if you BIOS supports

If you're using old machines, you may now choose to host victims on one machine adn attackers on another, but this is complicated. I'm assuming you don't do this, but it's your choice!

## Picking Hypervisorrs

Now you have your machine(s), it's time to get some VMs running on them. There are different types of hypervisors, which are called type 1 and type 2. Type 1 hypervisors run on hardware direct, as it they were their own operating system, but all they do is run VMs; type 2 are an application you run in an existing OS, which can run VMs.

Type 1 hypervisors enjoy high performance, so if you split your VMs across old hardware, you may choose to use one like [VMWare ESXI]() to host some VMs to attack from anotehr machine, for example.

There are a few virtualisation solutions out there, but the two that dominate the personal lab style use case are Oracle VirtualBox and VMWare Workstation. VMWare workstation has some really nice features and just…works, but it costs a lot of money for an individual hobbyist. VirtualBox is free and since your'e starting out, we'll focus on that.

## Picking guest OSs

Finally, you'll need some guest systems; as well as victims, we're going to install attacker machines. So, should you use Linux or Windows? It's obvious, yes you should.

I keep one Linux VM and one Windows for attacking; the Linux machine is usually a security oriented flavour of Linux like [Kali Linux](). Windows hacking toolsets don't really come packaged like this, so I usually complete a standard Windows install, apply some security settings, install Visual Studio, Wireshark, Nmap, Metasploit, NetCat, Python and Cain & Abel; everything else can just be installed as you go.

## Decide why you're building it - learn IT, defence, offense, all?

Think first about why you want your lab, then how you'll use it, then what you'll use it for. We'll try and get your lab to do what you want it to do.

### Do you have specific learning goals?

Are you looking to learn a specific technology? Do you need certain software? If so, you may need to think about getting hold of licences or hardware, things like Windows, Cisco equipment, or your favourite computer forensics tool.

If you want to learn a whole host of things, you may want to build a lab with lots of future opportunities; if you think you want to learn how to build a network environmebnt, you may need to get lots of computing recources together to support the wide range of machines. Maybe you need one machine, maybe you need many to work together.

### Do you want a lab quick and easy, or is it a learning challenge?

Are you wanting to get on, or could you use teh lab build as part of your learning? If you want to learn Linux, for example, why not build your lab on Linux machines?

### Mobile, static or hybrid?

Do you want to take your lab with you? Will you be travelling to a place of learning? Maybe you have old static hardware that you want to use? Maybe you want some mobile adn static parts, this could help if you want to repurpose adn old laptop, but use an old PC to help with heavier workloads when at home, for example.

### backups important, or just learn by regular rebuilds

How important will backups be to you? Not only do you need to think about how to protect the information you produce in your lab, ask yourself - will you be happy regularly rebuilding it all if everythign goes wrong?

If you want lots of backups, you may need to think about storage devices and save some equipment or money to cover that.

### do you need internet access, seperation or both?

Think about your networking requirements, will you want internet access? Will you want to separate some machines fromt eh internet? Will this be all the time? What about separating teh devices from one another (like a malware analysis machine vs your personal machine)?


# Build your shit

So now you know what you're picking from

## Hypervisors

You can get virtualbox at  https://www.virtualbox.org/, they make this very easy.

On Windows
On Linux

### Get VMs and install, put on the right networks

When VirtualBox is installed, you want some virtual machines (VMs) to actually run in it, otherwise you've installed a glorified system performance hindrance. First, we'll install our attacker machine and configure it. I recommend you start with Kali Linux, it's a Linux Distribution (google everything you think you need to) designed for security testing; it's based off a stable Debian build and is ideal for getting started. The good folks at Offensive Security prepare a Kali Virtual Machine that can be installed in a  few clicks from https://www.kali.org/downloads/:

Download these files, check the checksums in powershel/bash if you can (in powershell : 'certutil –hashflie ./<insert-path-to-file-here> sha256') and then head back over to VirtualBox. In virtualBox, open the file menu, go to 'import applicance', browse to the file and just do it…

Power the VM on, log in as root, with 'toor' as the password and you're there. Kali.org has more docs if you need them and loads of guidance on integrity checking Kali downloads too!

### Victims

The next step is to get something to attack, so head over to https://www.vulnhub.com/ and find a machine; I recommend looking for 'easy' VMs to start, a particular favourite of mine is 'Mr. Robot'. Do as above for kali, download it, check integrity if you can, import it, but DO NOT TURN IT ON. First, you should selet the VM, hit settings and configure the networking as in the next section; once done power it on and you'll save yourself some time getting things to talk to each other.

ONLINE, or homebrew also.

### A Note on virtual networks

VirtualBox provides virtual networks for your VMs to use https://www.virtualbox.org/manual/ch06.html; you can select which one you want to connect your VM to and VirtualBox will handle the rest. There are several networking modes, including custom, but the three you should be most interested in are bridged, NAT and 'host only'.

Bridged networking will put the VM on your network as if it were a real machine, this is bad if the VM happens to be vulnerable, or if you're worried about accidentally portscanning MI7. Only use this if you know why you're doing it.

NAT will hide the VM behind your host, this is good if you don't want it to be visible to the wider network, but is bad if you have poor host firewall configuration, or if you're worried about accidentally pinging into MI7  instead of Mr Robot. You can still talk out to the internet, so for this reason I recommend hooking a second NAT adapter up to your Kali machine and only using it when you need the internet (more info below).

Host only mode is 'safe', it lets you configure a virtual network in your machine that will allow your VMs to talk, but not reach the outside world. This is great if you want to avoid accidentally tweeting MI7.

Now you know the networking modes, consider the access they give each VM (https://www.thomas-krenn.com/en/wiki/Network_Configuration_in_VirtualBox):

You can use this table to decide when to connect adapters and which ones to use. I recommend choosing an adapter before you turn on a vulnerable VM, because you may not have login creds and if you can't talk to it, you may not be able to fix networking weirdness.

### Testing

#### Pinging the internet

#### DNS works

#### Pinging other clients

# Now what?


## Remember your drive


## Part 2
