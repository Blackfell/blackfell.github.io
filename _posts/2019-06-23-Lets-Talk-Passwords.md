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

Passwords are a pain. People forget them, you're told to use different ones for different accounts (because we all do that don't we?) and worst of all, we're not actually that good at making them.

This post is part of a short series, designed to let you be free to get on with the things you love in life and not worry about passwords any more!

The stealing of passwords (or some secret) has been at the heart of hacks against celebrities, US presidential campaigns and major corporate businesses. Whether you like it or not, passwords are probably the **first line of defence** in your online life and despite what you may have read, they're probably here to stay.

In this post I'll be taking you through some of the important points around passwords and in later parts I'll explain what you can do to cut through the noise of securing your passwords, reduce the mental load of remembering them and maybe even forget about 99% of them all together.

### Don't panic!

*There are some technical parts in this post, don't get hung up on them; they're there for people who want that extra information, but you'll get on fine if you skip, or don't totally get them.*

## What do I have to lose?

Your social media passwords may protect a lot of personal information, but may be less important than bank passwords, which protect your livelihood. The impact of a password compromise is important to consider because your protections may not be **proportionate**; simply, you may be under protecting one account, whilst overprotecting another.

Take a brief moment and think about the number of accounts you have, where they are and how important you think each is; how would you *feel* if someone else had control of an account?

Seem like a lot to think about? Don't worry we'll have tools for managing that later!

## A note on account dependencies and why your email is probably king

When considering impacts, it's also important to think about how your accounts are linked, because some accounts may lead to others; for most people this means email. Say you used your email account to set up Facebook, access to your email account can be used to reset your Facebook password. ON the other hand, maybe you use 'log in with Facebook' regularly, in that case, maybe you need to focus on Facebook the most, because it protects a lot of your acounts.

This will vary person to person, but the simplest way to think about this is best, focus on those key players; you probably don't need big lists and diagrams here!

# How passwords are hacked

Now you know why you need to care about passwords, what are the actual threats to them?

One of the things I do for a living is try and defeat passwords; there are lots of different ways to do this, but we can simplify these into three main groups:
1. Guessing
1. Breaches & Cracking
1. Social Engineering

Let's quickly go into the mechanics of each, before we get to how to fix it.

## Guessing
This is the simplest form to get to grips with; in this case, the attacker tries various passwords over and over for the given service you have an account for. This could range from guessing '1234' on a phone PIN up to automatically guessing your Facebook account password with a computer. This isn't necessarily letter by letter either, attackers can chain together letters, numbers, words and abbreviations at incredible speed; for some of them, their job is being good at guessing.

{% include figure
image_path="/assets/images/posts/password_problem/password_guessing.jpg"
alt="Password guessing image" caption="Password guessing of an online account - this involves the attacker trying one password after another until a successful logon is achieved. This can be done at incredible machine speeds with thousands of passwords per user in a short time." %}

Password guessing is sometimes prevented by the website or service in question (Captchas 'I am not a robot' tests or phone pin lockouts), but is still a real threat, especially if the attacker has some information with which to make informed guesses (think significant other's name, year of birth, exclamation mark).

This problem can be compounded when your passwords are the same across multiple devices or accounts; attackers can automatically try a good username and password for one online service across a large number of other sites. This is called 'credential stuffing'; this is why you're told to use those unique passwords across your devices and accounts.

## Breaches & cracking
Breaches happen when a company loses data either accidentally or as part of some deliberate attack. There have been numerous online breaches in the past, like the [Yahoo](https://www.infosecurity-magazine.com/news/yahoo-confirms-the-breach-of-500mn/){:target="_blank"}, [Adobe](https://krebsonsecurity.com/2013/10/adobe-breach-impacted-at-least-38-million-users/){:target="_blank"} and [RockYou](https://techcrunch.com/2009/12/14/rockyou-hack-security-myspace-facebook-passwords/?guccounter=1&guce_referrer=aHR0cHM6Ly9kdWNrZHVja2dvLmNvbS8&guce_referrer_sig=AQAAAHgn9MBfg8QnKtULXKCw3REA4Ckq7iQlR5isYkAMWQSYtOaunB_3y-erN-74U0BQMu2rgvv5M4lVk7qzStk8UcrTSQ3EvR8pUkfOTWmd3uGhU6ZN4gx5gvbh1-mFMmULmEOvP8vmDDjf_ib8-y7m8skEoTKIi9hE-9nbJWMAO5zi){:target="_blank"} breaches, and similar events continue to this day.

A breach may include all sorts of interesting data, but they can publicly disclose legitimate usernames and passwords from wherever the breech originates. Given these account details, an attacker could log into the service that lost your credentials, or try these in all the other sites and services you use (this is why users are told to use different passwords across sites). Both of these can be done automatically and much more easily than you may think.

If you're curious about breaches and whether you might be involved, Troy Hunt's [have I been pwned](https://haveibeenpwned.com/){:target="_blank"} site will let you look up your email address and see if you're part of one of the well known data breaches that have been made public. But remember! Just because you're not in there doesn't mean you're not in an *unknown* data breach.

### Hashes

Pure credential leaks like those mentioned above are becoming more rare (not as rare as you might like though); Most modern services don't save your password, Facebook, for example has publicly [stated that it stores a hash](https://www.facebook.com/notes/protect-the-graph/keeping-passwords-secure/1519937431579736?_fb_noscript=1){:target="_blank"} of passwords, so attackers can't just take any stolen passwords and log straight in with them. A [password hash](https://www.maketecheasier.com/what-is-password-hashing/){:target="_blank"} is an encoded version of a password that's easy to calculate, but so difficult to reverse that it's not worth trying.

{% include figure
image_path="/assets/images/posts/password_problem/hashing.jpg"
alt="Password hashing image" caption="Password hashing uses special mathematical algorithms to encode passwords into seemingly random (but not really) strings of characters. Changing just one character in a password can have a huge effect on the hash that's generated. Reversing hashes is not feasible using computers." %}

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

There are roughly 1.9 Billion Facebook users in the world at the time of writing; whilst in isolation a password may seem fairly unique; when you get everyone together though (like, say, on the internet) that unique password or system can quickly become common. To make this worse, you need to **remember** that password, meaning either you have a genius level memory, or you have to use a pattern or anchor to remember it, which makes it (by definition) less random than it could be.

The human element affects password security to such an extent that hackers have developed tools like [PyDictor](https://github.com/LandGrey/pydictor){:target="_blank"}, which will accept information about a given user (pet names, birthdays, phone numbers) and produce lists of passwords they're likely to use!

# Get to the point

So far, I've highlighted how to think about the impact of password breaches, told you passwords might be attacked and explained why human nature can hinder our password security. So it's all doom an gloom right?

Well no. And there is a point to my rant...

No system is perfectly secure, so big businesses try and make things 'just secure enough'; to do this they decide how important everything is, then use knowledge on attackers and their techniques to decide how likely you think an attack is. Hopefully this sounds familiar to you, since that's roughly what we've been doing so far.

## So what do I do then?

Well you have a feel for the threats and hopefully you can decide if you think the risks to you are acceptable or not at the moment. If you have a nagging thought in your mind that maybe you're at more risk than you thought, or if that little voice ever says *'This passwords a bit old now, I really should change it sometime.'*, or *'I know I use this one for my bank, but I can't remember another.'* , maybe it's time to make some changes. Don't worry, I'm here to help with that!

The solution to this problem has been done to death online, and goes as follows: **Use unique, long, hard to guess passwords, for every account you have and add other factors of authentication wherever supported**.

But I don't think this is clear, simple, or even accessible for a lot of the people I know. This is why I've created some guidance on how to practically achieve this as a normal person with real-life priorities, something I think is missing in the guidance we get day-to-day as users.

## Part 2 - The saga continues
That's why I made [part 2](/security guidance/threats & risk/Password-Fu-Level-1/) of this series, to you some practical, accessible examples of how to 'sort your life out' when it comes to passwords. **See you there.**
