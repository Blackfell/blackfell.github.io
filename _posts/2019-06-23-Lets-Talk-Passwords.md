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
title:  "Your password problem"
date:   2019-06-23 23:00:00 +0000
header:
  overlay_image: /assets/images/posts/password_problem/logon.jpeg
  teaser: /assets/images/posts/password_problem/logon.jpeg
excerpt: "Why passwords can be frustrating and what to do about it."
categories:
  - Security guidance
  - Threats & Risk
tags:
  - Passwords
  - Hashes
  - Cracking
  - Social Engineering
  - Breeches

---

# Why passwords in particular?

Passwords are a pain. People forget them, you're told to use different ones for different accounts (because we all do that don't we?) and worst of all, they have some major problems in practice.

But the stealing of passwords (or some secret) has been at the heart of hacks against celebrities, presidential campaigns and major corporate businesses. Whether you like it or not, passwords are probably the **first line of defence** in your online life and despite what you've read, they're probably here to stay.

This post is part of a short series, the goal of which, perhaps counter-intuitively, is for you to be free to get on with the things you love in life and not worry about passwords! In this post I'll be taking you through some of the important points around passwords and in later parts I'll explain what you can do to cut through the noise of securing your passwords, reduce the mental load of remembering them and maybe even forget about 99% of them all together.

### Don't panic!

*There are some technical parts in this post, don't get hung up on them; they're there for people who want that extra information, but you'll get on fine if you skip, or don't totally get them.*

## What do I have to lose?

Passwords let the right people get access to the right information on a device or service, by taking advantage of a shared secret. When we think about securing our accounts, we can forget to take a second to really think about what accounts we have and what the impact would be if they were broken into. Social media passwords may protect a lot of personal information, but may be less important than bank passwords, which protect your livelihood. The impact of a password compromise is important to consider because your protections may not be **proportionate**; simply, you may be under protecting one account, whilst overprotecting another.

Take a brief moment and think about the number of accounts you have, where they are and how important you think each is; how would you *feel* if someone else had control of an account?

Seem like a lot to think about? Don't worry we'll have tools for managing that later!

## A note on account structure and why your email is probably king

When considering impacts, it's also important to think about your account structure, because some accounts lead to others; for most people this means email. Say you used your email account to set up Facebook, access to your email account can be used to reset your Facebook password;   maybe you use 'log in with Facebook' regularly, in that case, maybe you need to focus on Facebook the most.

This will vary person to person, but the simplest way to think about this is best, focus on those key players; you probably don't need big lists and diagrams here!

# How passwords are hacked

Now you know why you need to care about passwords, what are the actual threats to them?

One of the things I do for a living is try and defeat passwords; there are lots of different ways to do this, but we can simplify these into three main groups:
1. Guessing
1. Breaches & Cracking
1. Social Engineering

Let's quickly go into the mechanics of each, before we get to how to fix it.

## Guessing
This is the simplest form to get to grips with; in this case, the attacker tries various passwords over and over for the given service you have an account for. This could range from guessing '1234' on a phone PIN up to automatically guessing well-informed passwords for your Facebook accounts based off your favourite flavour of ice cream. This isn't necessarily letter by letter either, attackers can chain together letters, numbers, words and abbreviations at incredible speed; for many it's their living.

{% include figure
image_path="/assets/images/posts/password_problem/password_guessing.jpg"
alt="Password guessing image" caption="Password guessing of an online account - this involves the attacker trying one password after another until a successful logon is achieved. This can be done at incredible machine speeds with thousands of passwords per user in a short time." %}

Password guessing is sometimes controlled by the service in question (think 'i am not a robot' tests or phone pin lockouts), but is still a real threat, especially if the attacker has some information with which to make informed guesses. Think Cat's name, year of birth, exclamation mark.

This problem can be compounded when your passwords are the same across multiple devices or accounts; attackers can automatically try a good username and password for one online service across a large number of other sites. This is called 'credential stuffing'; this is why you're told to use those unique passwords across your devices and accounts.

## Breaches & cracking
Breaches occur when a service or entity loses data either accidentally or as part of some deliberate attack. There have been numerous online breaches in the past, like the LinkedIn, Adobe and RockYou breaches, and similar events continue to this day.

If an attacker gets hold of some breached data, it may include all sorts of data, including legitimate usernames and passwords from the service or device they got it from. Given these account details, they could log into the service that lost your credentials, or try these in all the other sites and services you use (this is why users are told to use different passwords across sites). Both of these can be done automatically and much more easily than you may think.

If you're curious about breaches and whether you might be involved, Troy Hunt's [have I been pwned](https://haveibeenpwned.com/) site will let you look up your email address and see if you're part of one of the well known data breaches that have been made public. But remember! Just because you're not in there doesn't mean you're not in an *unknown* data breach.

### Hashes

Pure credential leaks like these are becoming more rare (not as rare as you might like though); Most modern services don't save your password, Facebook, for example has publicly [stated that it stores a hash](https://www.facebook.com/notes/protect-the-graph/keeping-passwords-secure/1519937431579736?_fb_noscript=1) of passwords, so attackers can't just take any stolen passwords and log straight in with them. A [password hash](https://www.maketecheasier.com/what-is-password-hashing/) is an encoded version of a password that's easy to calculate, but so difficult to reverse that it's not worth trying.

{% include figure
image_path="/assets/images/posts/password_problem/hashing.jpg"
alt="Password hashing image" caption="Password hashing uses special mathematical algorithms to encode passwords into seemingly random strings of characters. Changing just one character in a password can have a huge effect on the hash that's generated. Reversing hashes is not feasible using computers." %}

Because hashes are so difficult to reverse, they are often referred to as 'one way functions'. But this doesn't make them fool proof...

### Password cracking
Once an attacker has got hold of some hashes from a service, system, or data breach, they 'crack' them. Cracking can most easily be thought of as a 'guess', 'hash', 'compare' cycle; attackers guess what a password could be, hash the guess and then compare with the stolen hash. If the two hashes match, the attacker knows the guess is good.

{% include figure
image_path="/assets/images/posts/password_problem/cracking.jpg"
alt="Password cracking image" caption="When an attacker cracks passwords, they follow a 'guess, 'hash', 'compare' cycle until a matching hash is found." %}

Because cracking is done on an attackers own computer, they don't need to wait to see if a logon was successful and there's no risk they'll get locked out of an account; this means that cracking can be done incredibly fast and with little risk of getting caught.

## Social Engineering
Finally, there's the chance that you could be targeted by something called social engineering. In a social engineering attack, an attacker takes advantage of human nature to obtain your password. An attacker may produce a fake website for you to log onto and lure you to visit it, they may lure you into using some fake Wi-Fi, or otherwise trick some aspect of your in-built behaviours to get the password they want.

These attacks are some of the hardest to combat and will lead us to think carefully about protecting accounts. This also includes some cross-over with guessing and cracking; this attack may be used to get part of the information needed to log on, before guessing and cracking are used to get the rest.

Social Engineering, though, is a **huge** topic, which people can spend a whole career exploring; just remember that it's the business of tricking humans to do something the attacker wants and look out for future posts on the subject!

## The other thing with humans
As if these attacks and threats weren't bad enough, it's left up to the user to set a password, which leads us to further issues. When it comes down to it, picking hard-to-guess passwords is difficult and most of us are only human, meaning that we all generate passwords using the same equipment - the bit between your ears.

There are roughly 1.9 Billion Facebook users in the world at the time of writing; whilst in isolation a password may seem fairly unique; when you get everyone together though (like, say, on the internet) that unique password or system can quickly become common. To make this worse, you need to **remember** that password, meaning either you have a genius level memory, or you have to use a pattern or anchor to remember it, which makes it (by definition) less random.

The human element affects password security to such an extent that hackers have developed tools like [PyDictor](https://github.com/LandGrey/pydictor), which will accept information about a given user (pet names, birthdays, phone numbers) and produce lists of passwords they're likely to use!

# Get to the point

So far, I've highlighted how to think about the impact of password breaches, told you passwords might be attacked and explained why human nature can hinder our password security. So it's all doom an gloom right?

Well no. And there is a point to my rant...

No system is perfectly secure, so big businesses try and make things 'just secure enough'; to do this they decide how important everything is, then use knowledge on attackers and their techniques to decide how likely you think an attack is. Hopefully this sounds familiar to you, since that's roughly what we've covered so far!

## So what do I do then?

Well you have a feel for the threats and hopefully you can decide if you think the risks to you are acceptable or not at the moment. If you have a nagging thought in your mind that maybe you're at more risk than you thought, or if that little voice ever says *'This passwords a bit old now, I really should change it sometime.'*, or *'I know I use this one for my bank, but I can't remember another.'* , maybe it's time to make some changes. Don't worry, I'm here to help with that!

The solution to this problem has been done to death online, and goes as follows: **Use unique, long, hard to guess passwords, for every account you have and add other factors of authentication wherever supported**.

But I don't think this is clear, simple, or even accessible for a lot of the people I know. This is why I've created some guidance on how to practically achieve this as a normal person with real-life priorities, something I think is missing in the guidance we get day-to-day as users.

## Part 2 - The saga continues
That's why I made [part 2](/security guidance/threats & risk/Password-Fu-Level-1/) of this series, to you some practical, accessible examples of how to 'sort your life out' when it comes to passwords. **See you there.**
