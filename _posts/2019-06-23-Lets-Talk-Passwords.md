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
title:  "Let's talk about passwords"
date:   2019-06-23 23:00:00 +0000
header:
  overlay_image: /assets/images/generic/clouds.jpg
  teaser: /assets/images/generic/clouds.jpg
excerpt: "Why passwords can be frustrating and what to do about it."
categories: 
  - security guidance 
  - threats
tags: 
  - passwords 
  - 2 factor authentication
  - password managers
  - breaches

---

# The deal with passwords

Passwords are a pain, people forget them, you need different ones for different accounts (because we all do that don't we?) and worst of all, they don't really work that well. But before we get into that, why do we need to care about passwords of all things?

## Why pick on passwords?

Passwords are the cornerstones of securing our daily lives, our money, social lives and jobs all rely on them, but passwords can be cracked, guessed or breached. Each of these attacks are subtly different, but each could lead to significant damage to the lives of many.

### Guessing
This is the simplest form to get to grips with; in this case, the attacker tries various passwords over and over for the given service you have an account for. This could range from guessing '1234' on a phone PIN up to automatically guessing well-informed passwords for your facebook accounts based off your favourite flavour of ice cream.

### Breaches
Breaches are seemingly becoming more and more common; they occur when a service or entity loses data either accidentally or as part of some deliberate attack. There have been numerous breaches in the past, like the LinkedIn, Adobe and RockYou breaches; these events continue to this day, some include lost passwords, some only limited data. 

Given breech data, an attacker may have, at worst, legitimate credentials; they could use these to log into the service that lost your credentials, or try these in all the other sites and services you use (this is why users are told to use different passwords across sites). This can be done automatically and much more easily than you may think.

### Cracking
Password cracking is, generally, much quicker than password guessing and considerably safer for an attacker once started. Most modern services don't save your password, Facebook, for example has publicly [stated that it stores a hash](https://www.facebook.com/notes/protect-the-graph/keeping-passwords-secure/1519937431579736?_fb_noscript=1) of passwords; a hash is a short string of characters that looks random to human eyes, but can be easily calculated from a password; given a hash though, it is extremely difficult to calculate what password was used to make it. For this reason hashes are often called 'One Way Functions' and they're effective because of fundamental maths principles, so the security industry sees them as reliable and relies on them heavily.

Cracking involves an attacker stealing hashes from a service, system, or maybe getting hem from a data breach; once held, they can't be reversed, so the attacker guesses the password locally, calculates the hash and checks it against the known hash. If both hashes are identical, the password has been found. This can be done incredibly fast.

When this happens it can be targeted, or it can be random. Actually a lot of previous hacks and breeches have been a real issue for customers and your password being breached can mean you lose accounts, money, or even your identity.

## Why are these attacks such a problem? 

Simply put, it's because it's left up to us to set them. When it comes down to it, picking hard-to-guess passwords is difficult and most of us are only human (no offense internet bots).

### But no-one will ever guess my password (system)
I understand your stance, you've hopefully got a lot of passwords and chances are you use some system to bring order to the password chaos, it's only natural to do so and it **might** be unique. The problems come when we ask whether you password (system) is unique **enough**.

### The Birthday Problem
If you meet a random person in the street, let's ignore leap years, you have a 364/365 chance of sharing a birthday. This means there's just over a 3\% chance that you share a birthday. If you get 10 people together, the chances of a birthday 'collision' jumps to about 12%, 40 people 89.1% and by the time there's 60 people, the chances that two of you share a birthday are over 99%. 

This is called [The Birthday Problem](https://en.wikipedia.org/wiki/Birthday_problem) and it seems counter-intuitive, but this is why it's so important. We can now think about the 1.9 Billion Facebook users in the world, imagine just how many birthday collisions there must be!

### But why tell me this?

Well password security is similar to the birthday problem, in isolation a password, or password system may seem fairly unique; problems can arise, though, where many of us use too similar systems in one place, like - say - the internet!

What if we're all more similar than we realise? My mum says I'm 'special' but I know I'm not **that** special; other people share my hair colour, (excellent) taste in music and (*ahem*) taste in clothes. This is why I find I have 'SO MUCH IN COMMON' with other drunk people; but what if my password system has 'SO MUCH IN COMMON' with every other human in the world?

### Password rules.
This whole problem is made all the worse by the rules placed on you for online accounts, banks, or maybe your own computer (the indignance!); these rules mandate X characters, Y kinds of characters and three-monthly changes (roughly once per season). 

These rules render systems like '[Wife's Name][Wife's Year of birth][!]' woefully common; one can simply change the special character from ! to " each season, right? Worse still is the fact that the passwords Spring2019, Summer2019, Autumn2019 and Winter2019 are all valid 'complex' passwords for some business IT systems that require their seasonal password rotation. Ironic?

### Social engineering
Then there's the chance that you could be targeted directly; the building of password guess-lists for people based on their interests, pet names, age, favourite cereal and musical interests is a wide adn well-documented field. Suffice it to say that there are multiple tools to help with this.

## What can we do about it?

Simple – Panic! Or… make it go away? I recommend three simple password security tips, in order of ease (and therefore priority):

(1)    Don't use passwords at all – use a passphrase.

a.       When I say passphrase, I mean a collection of words chained together; why? Well for password guessing attacks, this means you'll have to guess for a lot longer on average than a short password and I think it aids memorability. preferably use a random word generator and chain together as many words as it makes sense to remember. If you're picking them truly randomly for a large set of words, three is an ok number to start with (you'll get better), and who could forget the phrase 'publictoiletguilt' anyway?

(2)    Use a [Password Manager](my password manager link)

a.       Password managers are great, forget all your passwords but one, create better passwords with a machine, never lose a password, keep them organised and share them with people as you need.

(3)    Use two factor authentication

a.       No matter how good your password is, it can be compromised if you just tell it to someone, type it in a compromised site or PC, or even if a site is breached. Two factor requires a second thing to log in. Your password is something you know and your other factor should be something you are or have, like a hardware token or fingerprint. SMS is an OK way of doing this, but there are concerns around its security, I recommend a 2FA app like Authy, making your phone the second factor, but if you're willing to invest, a hardware token like a Yubikey is the way to go.

## That sounds hard and also annoying

No. Well it doesn't have to be. And it can be totally Free. How many accounts do you have? I bet it's more than you think. I bet you don’t' even realise the mental load you're bearing by remembering all those 'different' passwords you use for your accounts (FluffyBunny23, FluffyBunny24 and so on). Wait, what's that you say? You don't need to remember them? They're usually just logged in via 'magic'? Well I want to post on this 'magic' in future, but for now, let's just agree that you're right.

So you never log into things, meaning logins are rare for you? Great! Set up as many of the above points as you can, prepare some passphrases (write them down to go in your safe if you want), download a [password manager](link to blog), or [setup a Two factor Authentication solution](blog) and wait for a logon event. If you can't decide, get a free password manager, like Authy, Dashlane, Password1 or whatever, I don't care, and download Authy the 2FA app. Sign up and secure the apps with a  5 word passphrase of randomly generated words; write these down and keep them safe and secret (Gandalf).

Now, whenever you log in afresh to a service, change your password, put it in your password manger if you have one, and add two factor authentication. This will happen slowloy, but I bet that the more you progress the more you'll love it.

Still hate passwords? Yeah me too.
