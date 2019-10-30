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
title:  "School's Out"
date:   2019-07-15 23:00:00 +0000
header:
  overlay_image: /assets/images/posts/start_hacking/empty_corridoor.jpg
  teaser: /assets/images/posts/start_hacking/empty_corridoor.jpg
excerpt: "Finding your path to enlightenment."
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


feature_row1:
  - image_path: /assets/images/posts/start_hacking/darknet_diaries.jpg
    alt: "Darknet Diaries"
    title: "Darknet Diaries"
    excerpt: "**The one for your nan** - Dramatic narratives of famous incidents; everyone can keep up with [Jack Rhysider's](https://twitter.com/jackrhysider) presenting style."
    url: https://darknetdiaries.com
    btn_label: "Read More"
    btn_class: "btn--inverse"
feature_row2:
  - image_path: /assets/images/posts/start_hacking/malicious_life.png
    alt: "Malicious Life"
    title: "Malicious Life"
    excerpt: "**The one for your cousin** - Narratives of famous incidents, malware and groups; [Ran Levi](https://twitter.com/ranlevi) gets a little more technical, which is great for those that can handle it."
    url: https://malicious.life/
    btn_label: "Read More"
    btn_class: "btn--inverse"
feature_row3:
  - image_path: /assets/images/posts/start_hacking/sans_isc.jpg
    alt: "SANS ISC Stormcast"
    title: "SANS ISC Stormcast"
    excerpt: "**Thee one for your 10 minute commute** - News podcast from SANS, the host [Johannes Ullrich](https://twitter.com/johullrich) is highly knowledgeable and very technical."
    url: https://isc.sans.edu/podcast.html
    btn_label: "Read More"
    btn_class: "btn--inverse"
feature_row4:
  - image_path: /assets/images/posts/start_hacking/cyberwire.jpg
    alt: "The Cyberwire"
    title: "The Cyberwire"
    excerpt: "(the one for your boss) - Accessible Cyber news, in plain English; there are jokes, accents and good ol' American cheese, but it's a great place to start to understand how businesses treat security."
    url: https://www.thecyberwire.com/podcasts/daily-podcast.html
    btn_label: "Read More"
    btn_class: "btn--inverse"

---

# So you want to learn security?

Perhaps you're new to a job, starting a course, of just plain interested; whatever the reason you're here, the sheer volume of options available to you can be daunting. Let's cut through the noise and get you some solid (if opinionated) learning recommendations that I've found successful working with friends and colleagues.

This is a guide of two parts. First up is Immersion101, a compressed brief I like to give friends an colleagues that are getting into InfoSec; the second part will focus on some technical, hands on learning strategies, which is, as far as I'm concerned, *by far the best bit!*

# Immersion 101

I like to encourage people to build a general, risk oriented and well informed view of the security world. In my opinion, the best way to do this is to immerse yourself; hang out on social media, listen to news, read articles and watch videos. Consume. Assimilate.

## Catching Podcats & Pugcasts

A great place to start is with some podcasts; these are free, don't require an account and have lots to give. Here are a few suggestions, pick those that sound most helpful to you; if you find more, send them my way!

{% include feature_row id="feature_row1" type="left" %}
{% include feature_row id="feature_row2" type="right" %}
{% include feature_row id="feature_row3" type="left" %}
{% include feature_row id="feature_row4" type="right" %}

You can download a 'podcatcher' app on your phone, subscribe to a few shows an take it from there; like me, you'll find referrals in the shows you like that will point you to more interesting content.

## Social lurking

Social media is fairly limited in Information Security and though it pains me to say it, InfoSec Twitter is an active and interesting place to pick up news, opinions, reports and blog posts.

Some people use Twitter as a platform for tool releases:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I&#39;ve released PoisonTap; attacks *locked* machines, siphons cookies, exposes router &amp; backdoors browser w/RasPi&amp;Node <a href="https://t.co/mbTAti33wy">https://t.co/mbTAti33wy</a></p>&mdash; Samy Kamkar (@samykamkar) <a href="https://twitter.com/samykamkar/status/798857880015245312?ref_src=twsrc%5Etfw">November 16, 2016</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Some post details of new exploits and vulnerabilities, often including blog posts to explain them to you:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Initial Metasploit Exploit Module for BlueKeep (CVE-2019-0708) <a href="https://t.co/TOeXhRH52B">https://t.co/TOeXhRH52B</a></p>&mdash; HD Moore @ Texas Cyber Summit (@hdmoore) <a href="https://twitter.com/hdmoore/status/1170046501042753536?ref_src=twsrc%5Etfw">September 6, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

There's two accounts you can follow for starters, but just start with [searching for the hashtag #InfoSec](https://twitter.com/search?q=%23InfoSec&src=typed_query); since obviously you already [follow me](https://twitter.com/blackf3ll) (!) you could always follow my follows.

But beware! InfoSec Twitter can also be a less-than-friendly environment; it's worth the risk adn getting better, so remember, when the fun stops, stop.

## Online training

If you're totally new to the security game, I recommend you focus of your reading and training on security basics; learn about security risk and why businesses use risk, learn about systems administration, networking and programming.

I like the following online training providers:

1. SANS [Cyber Aces](https://www.cyberaces.org/) - A Free offering from a leading training provider to introduce you to InfoSec.
1. [Cybrary](https://www.cybrary.it/) - Online free training provider popular in IT and InfoSec.
1. [Hacker101](https://www.hacker101.com/) - A Free training course associated with the Hacker1 [bug bounty](https://en.wikipedia.org/wiki/Bug_bounty_program) program.
1. [Codeacademy](https://www.codecademy.com/learn/learn-python) - free programming courses from web application programming to full on development practices.

If nothing grabs your eye, I recommend CompTIA training courses in Security+ Network+ and A+ to total beginners as a starting place; these can be supplemented with Microsoft, Linux and Cisco sysadmin courses; all of which can be found for free via Cybrary (number 2.).

Whilst these are good, remember **don't get bogged down in them yet**, read on, build some things and use the training to support where you'd like to find out more on specifics.

## Reading material

Whilst you may get lots of reading material from Twitter and training courses, there are a few places that might be worth a regular look for interesting tech reading. I like to keep an eye on:

1. [Krebs on Security](https://krebsonsecurity.com) - Regular, in depth articles on all things security.
1. [Hacker News](https://thehackernews.com) - Accessible articles that are a little more like 'popular reading'.
1. [Security Weekly](https://securityweekly.com) - A more business focused news site; great for insights into hos businesses approach security.
1. [NewsNow](https://www.newsnow.co.uk/h/Technology/Security) - A great source of various articles; consider this your screen-scraper for security news, they have everything.

# Hands on Learning

![We got 'em R2](/assets/images/posts/start_hacking/where_the_fun_begins.gif)

OK now you have your grounding, lets get into my favourite learning strategy - hands on, project based learning. This is where I encourage people to channel as much of their learning energy as possible; it has the added benefit of being *far* more engaging than reading books.

## Why lab is fab

To get started on this part of your journey, we'll build a lab; a lab gives you a playground, where you can release all your hacking tools and malware friends, and have fun without worrying (too much) about them jumping the fence and following you home. You'll be able to use your lab to attack deliberately vulnerable machines in a safe, controlled environment, so you can learn & have fun.

![sandbox meme here](/assets/images/posts/start_hacking/sandbox.jpg)

Remember, if you practice on a system without authorisation, even if without malicious intent, you are probably breaking the law (depending where you are). Be careful. Check your local laws.

At this point, you may be asking me - **This is a lot of prep, do I really need a lab?** Well you can, in principle, start your learning journey with simple browser, or just a Secure Shell client, by working on online learning programs only; this option is best if you have really limited resources, or some existing IT that won't perform. I try and encourage people to build a lab, even if this is their learning plan, because I think it gives valuable experience that will support 99% of learning goals.

If you have good reasons to not use a lab, then read on the how to use it section below and take out those recommendations for online challenges only.

## Putting that Lab to good use

You can use a lab to learn anything you want, it all depends what you want to do and I **always** suggest that you follow your interests. A general rule of thumb though, is exactly the same as that I set out in [the online training section](#online-training) - focus on systems admin, networking and programming, then progress to security specific training.

If you're a total novice to this, I recommend starting by learning tech basics, install and configure computers and networks, learn to use them with graphical and text interfaces; after you have a basic working knowledge, you can then progress to security specific learning.

There are various online and 'offline' security learning approaches; you can complete online challenges, use your lab to build and configure technology, download public challenges to solve in your lab, or even create your own challenges.

### Sysadmin crash course

![No wizards here](/assets/images/posts/start_hacking/wizard.jpg)

An effective way of learning foundations skills in systems administration, networking and programming, is building things. If you're not able to do any of the following, I recommend considering doing them as a learning task early on in your training plan:

1. Installing and configuring a Windows server and client(s) in a secure manner; bonus points for implementing central authentication & other services. Hint - free online training can help here.
1. Installing and working in a Linux environment; get comfortable using the command line (it's not dead yet by a long shot) and satisfy yourself you can find files by name, content & permissions. Can you see what processes are running, who's logged in, can you check some basic logs, can you manage and configure a service like ssh?
1. Configuring networking settings on Windows, Linux and networking appliances; try setting up a network with a couple of devices, your own custom address range (bonus points for fancy sub-netting) and check everything can talk successfully.
1. Basic Scripting and programming - this one marries really well with 1 & 2; try using native scripting languages like PowerShell and Bash to find files on computers. Try some basic python, maybe do an online course.

The above are examples you could use a s a start; you don't need to take them to the far end of one, but consider getting to a reasonable working level in each, to help you with other tasks.

### Offline Vulnerable Targets

OK the juicy offline stuff! This is my go to recommendation for security specific training, once people are comfortable with technology basics; this approach involves getting hold of vulnerable machine builds, putting them on a computer (usually virtually, but we'll come on to that later), and breaking in to them.

{% include figure image_path="/assets/images/posts/start_hacking/trinity_nmap.jpg" alt="Starting to feel like you got this?" caption="This is the part where you can start to feel like you're channelling Trinity, with her real life Nmap skills." %}

There are a whole host of these out there, but I almost always send people to [Vulnhub](https://www.vulnhub.com/); Metasploitable is often recommended as a beginner task, but I'd give caution, as it's lack of workflow and artificial nature can sometimes confuse, or demotivate people.

I like to start people on a [Mr robot themed machine](https://www.vulnhub.com/entry/mr-robot-1,151/); many people are fans of the show (which helps with keeping interest) and I think it's a nice balance of realism and simplicity. As an added bonus, I have produced a [learning-oriented walkthrough]() for the machine, to turn it into a proper learning experience.

Machines aren't the only thing you could go for; you could look to do some wireless security testing in your local environment, you may decide you'd like

### Online learning providers

We covered online learning in Immersion101, by recommending courses & videos, but this is a different kind of online learning, which gives us way more value.

{% include figure image_path="/assets/images/posts/start_hacking/part_deux.jpg" alt="This is part deux!" caption="eLearning and video time is over; it's time for something more hardcore. Bring on a challenge worthy of Part Deux." %}

The Online training providers I really value offer interactive hosted challenges for you to work on and develop your skills; some require you to use your own attacking machine, but some may even host a whole load of your attacker functionality on them too, meaning you only need a browser. This can be a real complement, or even an alternative to using offline machines to learn against.

The good news with online interactive learning is that you may need fewer resources and may not need a fully fledged lab; I usually discourage this approach however, unless you really can't afford to do so. Some good examples of online challenges are:

#### OverTheWire - bandit

{% include figure image_path="/assets/images/posts/start_hacking/over_the_wire.jpg" alt="OverTheWire - Bandit." caption="Over the wire's [Bandit](https://overthewire.org/wargames/bandit/) machine - A Linux command line challenge, which will test & develop your abilities to gather information from Linux machines and work in a Linux command line environment." %}

OverTheWire offer a whole suite of challenges, which are *really* accessible; Bandit is a Linux command line challenge, where you can test and hone your skills, using only a Secure Shell client. Even Linux pros will have fun here.

#### SANS Holiday Hack

{% include figure image_path="/assets/images/posts/start_hacking/holiday_hack.jpg" alt="OverTheWire - Bandit." caption="The SANS [Holiday Hack](https://holidayhackchallenge.com/) challenges - Humorous online hack-a-thons, whose previous years are still hosted; you may need your own machine for some of the harder stuff, but you can get a long way in a browser." %}

The SANS Holiday Hack is a really fun online challenge; you can get started with nothing but a browser on many of the challenges and the web based game-style of the challenges is really accessible. There's a great community around these when they are live and the old ones are all still hosted so you can go back and practice.

#### HackTheBox

{% include figure image_path="/assets/images/posts/start_hacking/hack_the_box.jpg" alt="OverTheWire - Bandit." caption="[Hack the box](https://www.hackthebox.eu) - A online lab you remote into; bring your own attacking machines and let rip at the hosted victims." %}

HackTheBox offer a virtual lab environment you can hack against; this is great for people who are more comfortable working basic CTF challenges, but the forums have plenty of support, so don't rule this out if you're looking for introductory options.

#### HackThisSite

{% include figure image_path="/assets/images/posts/start_hacking/hack_this_site.jpg" alt="OverTheWire - Bandit." caption="[hackthissite](https://www.hackthissite.org) - A website with challenges that allow you to discover and exploit web application vulnerabilities." %}

HackThisSite is all about Web hacking; the site is free to use and doesn't really require any fancy software beyond your humble browser. This can give you some really good experience, but I usually push people to the other options here first as the scope of learning here is a little more narrow.

All of the above are interesting places to get started; I generally recommend them in order of appearance, as despite hackthisstie being aimed at beginners, I prefer other options unless you're resource constrained.

### Offline Home-brew Victims

A third option (which in most cases is really similar to the last) is making home-brew targets. This can give you a nice halfway house between dedicated offline targets and online services; you can use vulnerable applications, or old machines to test your skills against, without the hard requirement for running dedicated target machines,though you should, as you may crash or corrupt the device you're working with, and you may lose some of the separation benefits we've discussed so far.

OWASP offer a [vulnerable web server](https://github.com/OWASP/Vulnerable-Web-Application) project, the [Damn Vulnerable Web Application](http://www.dvwa.co.uk/) project offers a slightly more usable alternative and there are others available too.

These have the appeal of not requiring a dedicated machine, but I usually don't recommend them at first due to the extensive setup effort and the chance that you may have misconfigurations that affect your learning.

# So go and do it!

Hopefully you have a rough idea now of where you want your learning to take you. Depending on your current experience, you may want to take a look at windows configuration, or the Linux [bandit](https://overthewire.org/wargames/bandit/) challenge, or you may be comfortable with your knowledge and ready to jump straight into some vulnerable VMs, or a virtual lab.

## Still not sure?

OK then, you need a nudge don't you? It's OK to not be sure and I'm happy to provide some hints, here goes!

If you can install windows machines, get a server talking to a client, use PowerShell to {download a file, find a file on disk and ping all hosts on your local network} then skip basic windows learning; otherwise, configure a Windows server and client, in a mini Active Directory environment. Make sure you comply with licensing requirements, even if you use [evaluation copies](https://www.microsoft.com/en-us/evalcenter/).

If you can install Linux and use the command line to {find a file, add a new user, list running processes, configure and enable ssh on port 9999 and ping every host on your local network} then skip bandit and local Linux config tasks; otherwise, install some Linux in a lab environment (see next post) and/or complete the [bandit](https://overthewire.org/wargames/bandit/) overthewire challenge.

If you know what an IP address is, what a network port, MAC address and the difference between a router and switch is, then skip a basic networking course for now (but it's super important - you'll pick more up and train as required), otherwise, try a free course like Cybrary's [CompTIA Network +] (https://www.cybrary.it/course/comptia-network-plus/) offering.

If you know the basics of how websites are programmed and you know your HTML from our JavaScript, what an SQL query is and how CSS works (note, you don't need to be a master), then skill any web learning, otherwise, consider completing some web programming learning, like that offered by [codeacademy](https://www.codecademy.com/learn/paths/web-development) or [w3schools ](https://www.w3schools.com/). Just getting a rough understanding at this point will help.

Otherwise, I recommend you try the [Mr Robot Capture the Flag](https://www.vulnhub.com/entry/mr-robot-1,151/) challenge as a starter task, using my (very excellent) [walkthrough]() as a training guide.

In due time, I'd recommend you bolster your web programming knowledge with another programming or scripting language, though this isn't wholly essential at first (IMO). I like Python and codeacademy](https://www.codecademy.com/learn/learn-python) offer good training. This one is up to you though!

After that, you should have a feel fro where you'd like to go now; as always, contact me via social for more thoughts and advice.

# Now What?

I've told you what to do, but how do you do it? Well I believe it all starts with getting your lab together, so let's head over to the next post [building a lab](/technical guidance/labs & hacking/building-a-lab/) and get our house in order to get cracking.
