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

Passwords are a pain. We're told to use complicated ones, change them for every site every few months, we forget them and worst of all, we're not actually that good at making them. But it doesn't have to be this way at all.

This post is part of a short series, designed to let you be free to get on with the things you love in life and not worry about passwords any more!

The stealing of passwords (or some secret) has been at the heart of so many breaches, hacks and takeovers (or whatever you want to call them!). Whether you like it or not, passwords are probably the **first line of defence** in your online life and despite what you may have read, they're probably here to stay.

## What will we do about it?

In this post I'll be taking you through some of the important weaknesses and considerations around passwords and in later parts I'll explain what you can do to cut through the noise of advice and get a simple plan to get over the password problem.

### Don't panic!

*There are some technical parts in this post, don't get hung up on them; they're there for people who want that extra information, but you'll get on fine if you skip, or don't totally get them.*

## What do I have to lose?

As we start to fix up your passwords, take a quick breath to think about what accounts you have and which are most important to you - you can then take the advice in this and future posts and apply it to those accounts first. It's important to take a moment on this, because it's not always obvious where to begin; try to think about how your accounts are linked, because some accounts may lead to others.

For most people this means email, your email can probably be used to reset every other account you have if you try hard enough; this can vary person to person, so if you're different, then go for your most important 'core' accounts. Other following contenders are usually financial, cloud storage and social accounts.  

# How passwords are hacked

Now you know why you need to care about passwords, what are the actual threats to them?

There are lots of different ways to do defeat passwords, but we can simplify these into groups:
1. Guessing
1. Breaches & Cracking
1. Social Engineering
1. Stuffing

Let's quickly go into the mechanics of each, before we get to how to fix it.

## Guessing
This is the simplest form to get to grips with; in this case, the attacker tries various passwords over and over for the given service you have an account for. This could range from guessing the PIN '1234' on a stolen phone, to automatically guessing your Facebook account password over and over using a computer, in very clever ways.

{% include figure
image_path="/assets/images/posts/password_problem/password_guessing.svg"
alt="Password guessing image" caption="Password guessing of an online account - this involves the attacker trying one password after another until a successful logon is achieved. This can be done at incredible machine speeds with thousands of passwords per user in a short time." %}

Password guessing is sometimes prevented by the website or service in question (Captchas 'I am not a robot' tests or phone pin lockouts), but is still a real threat, especially if the attacker has some information with which to make informed guesses (lot's of people use their significant other's name, year of birth + exclamation mark, for example).

## Breaches & cracking
Breaches happen when a company loses data either accidentally or as part of some deliberate attack. There have been numerous online breaches in the past, like the [Yahoo](https://www.infosecurity-magazine.com/news/yahoo-confirms-the-breach-of-500mn/){:target="_blank"}, [Adobe](https://krebsonsecurity.com/2013/10/adobe-breach-impacted-at-least-38-million-users/){:target="_blank"} and [RockYou](https://techcrunch.com/2009/12/14/rockyou-hack-security-myspace-facebook-passwords/?guccounter=1&guce_referrer=aHR0cHM6Ly9kdWNrZHVja2dvLmNvbS8&guce_referrer_sig=AQAAAHgn9MBfg8QnKtULXKCw3REA4Ckq7iQlR5isYkAMWQSYtOaunB_3y-erN-74U0BQMu2rgvv5M4lVk7qzStk8UcrTSQ3EvR8pUkfOTWmd3uGhU6ZN4gx5gvbh1-mFMmULmEOvP8vmDDjf_ib8-y7m8skEoTKIi9hE-9nbJWMAO5zi){:target="_blank"} breaches; similar events continue to this day.

A breach may include all sorts of interesting data, but they can publicly disclose legitimate usernames and passwords from wherever the breech originates. An attacker who causes a breach, or who buys access to breach data can use these details to steal accounts and the most frustrating part is that as a user, you may have done everything right with you password, but it still gets leaked!

If you're curious about breaches and whether you might be involved, Troy Hunt's [have I been pwned](https://haveibeenpwned.com/){:target="_blank"} site will let you look up your email address and see if you're part of one of the well known data breaches that have been communicated to the site owners. But remember! Just because you're not in there doesn't mean you're not in an *unknown* data breach.

### Hashes

Pure password leaks like those mentioned above are becoming more rare (not as rare as you might like though); Most modern services don't save your password, because breaches of that information are really bad for their customers.

For example, [Facebook has stated](https://www.facebook.com/notes/protect-the-graph/keeping-passwords-secure/1519937431579736?_fb_noscript=1){:target="_blank"} that instead of storing users passwords, they store a [password hash](https://www.maketecheasier.com/what-is-password-hashing/){:target="_blank"}, which is basically a way of verifying that you know a password without having to store the actual value.

The way this works is by taking the password and using it to do a complex mathematical calculation. These calculations are designed to be easy enough to work out, but so difficult to reverse that it's not worth trying, a bit like how most people find multiplying numbers easier than dividing them. Instead of checking the password, Facebook can work out the hash and then check it's correct, without ever having to store your password.

{% include figure
image_path="/assets/images/posts/password_problem/hashing.svg"
alt="Password hashing image" caption="Password hashing uses special mathematical algorithms to encode passwords into seemingly random (but not really) strings of characters. Changing just one character in a password can have a huge effect on the hash that's generated. Reversing hashes is not feasible using computers." %}

Because hashes are so difficult to reverse, they are often referred to as 'one way functions'. But this doesn't make them fool proof...

### Password cracking
Once an attacker has got hold of some hashes from a service, system, or data breach, they 'crack' them. Cracking can most easily be thought of as a 'guess', 'hash', 'compare' cycle; attackers guess what a password could be, hash the guess and then compare with the stolen hash. If the two hashes match, the attacker knows the guess is good.

{% include figure
image_path="/assets/images/posts/password_problem/cracking.svg"
alt="Password cracking image" caption="When an attacker cracks passwords, they follow a 'guess, 'hash', 'compare' cycle until a matching hash is found." %}

Because cracking is done on an attackers own computer, they don't need to wait to see if a logon was successful and there's no risk they'll get locked out of an account; this means that cracking can be done incredibly fast and with little risk of getting caught.

## Social Engineering
There's the chance that you could be targeted by something called social engineering. Social Engineering is a **huge** topic, which people can spend a whole career exploring, but for our purposes, we're most interested in an attacker taking advantage of human nature to obtain your passwords.

An attacker may produce a fake website for you to log onto and lure you to visit it, they may lure you into using some fake Wi-Fi, or otherwise trick some aspect of your in-built behaviours to get the password they want. This can be one of the hardest attacks to defend against, because once successful, your account can be fully compromised.

## Stuffing

Every attack above can be compounded when your passwords are the same across multiple devices or accounts; once a single type of attack (Guess, Crack, Social Engineering)has been carried out, attackers can automatically try your details on a **huge** number of other services. This is called 'credential stuffing' and is the main reason you're told to use those unique passwords across your devices and accounts.

## The other thing with humans
Right now, there are roughly 2 Billion Facebook users in the world and most of us generate passwords using the same equipment - the bit between your ears. Whether you like it or not, when you get that many people together somewhere (like, say, on the internet) that unique password or system you have (yes, even the one where you run your finger down the top row of the keyboard) can quickly become quite common.

To make this worse, you need to **remember** that password, meaning either you have a genius level memory, or you have to use a pattern or anchor to remember it, which makes it (by definition) less random than it could be.

The human element affects password security to such an extent that hackers have developed tools like [PyDictor](https://github.com/LandGrey/pydictor){:target="_blank"}, which will accept information about a given user (pet names, birthdays, phone numbers) and produce lists of passwords they're likely to use!

# Get to the point

So far, I've highlighted how to think about the impact of password breaches, told you passwords might be attacked and explained why human nature can hinder our password security. So it's all doom an gloom right?

Well no. And there is a point to my ramblings...

## So what do I do then?

Well you have a feel for the threats and hopefully you can decide if you think the risks to you are acceptable or not at the moment. If you think it's time to make some changes, don't worry, it's much easier than you think and I'm here to help with that!

The solution to this problem has been done to death online, and traditionally goes as follows: **Use unique, long, hard to guess passwords, for every account you have and add other factors of authentication wherever supported**.

But I don't think this is clear, simple, or even accessible for a lot of the people I know. This is why I've created some guidance on how to practically achieve this as a normal person with real-life priorities, something I think is missing in the guidance we get day-to-day as users.

## Part 2 - The saga continues
That's why I made [part 2](/security guidance/threats & risk/Password-Fu-Level-1/) of this series, to you some practical, accessible examples of how to 'sort your life out' when it comes to passwords. **See you there.**
