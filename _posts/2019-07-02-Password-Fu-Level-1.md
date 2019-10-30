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
title:  "Password Kung-Fu"
date:   2019-07-02 23:00:00 +0000
header:
  overlay_image: /assets/images/posts/password_level_1/nes.jpeg
  teaser: /assets/images/posts/password_level_1/nes.jpeg
excerpt: "Cyber self defence - Level 1."
categories:
  - Security guidance
  - Threats & Risk
tags:
  - Passwords
  - Two Factor Authentication
  - Password Managers
  - Account Security

---

# Ready Player One

You're here to improve your security and this is the first level; you're about to take control of your passwords and start winning the game.

In [part one](/security guidance/threats & risk/Lets-Talk-Passwords/) of this series, I explained why your account passwords are the first line of defence in your digital life. This post is the follow up, so if you're ready to take control, buckle up.

## Level Outline

The *'boss'* in this level is a collection of traps people fall into when making passwords; we'll be beating this boss together with **a passphrase worthy of greatness**, that you will generate yourself.

This will be a human generated passphrase, which we'll be using as we move on to future posts, watch this space!

# The Basics

This part of your training is, as with all great movie montages, all about the basics.

![Wax on](/assets/images/posts/password_level_1/wax_on.jpg)

Lucky for us, instead of hitting a punch bag for hours, or crashing bobsleighs, you get all the journey and none of the mystery - you get to take a shortcut straight to the answer.

As mentioned in [Part 1](/security guidance/threats & risk/Lets-Talk-Passwords/), passphrases must be **hard to guess, unique, memorable and secret**. This post is all about building these passphrases, without them being impossible to remember. We must be careful of avoiding some common traps though!

![It's a trap](/assets/images/posts/password_level_1/trap.gif)

## Trap 1 - Complexity Requirements

Password requirements from sites and systems can be the bain of strong passwords. Encouraging a formulaic combination of character types has a tendency to get humans to produce formulaic passphrases. If the requirement is a mix of upper-case, lower-case and numbers, someone who dreams up the passphrase flower, will have a tendency to change it to Flower1, or some similar derivative.

By the time a whole population does this, the patterns can be quite common; so we find Trap # 1.

## Trap 2 - Predictable Systems

Related to trap # 1 is predictable systems; this occurs where we users design a password system to get around the difficulties of picking and remembering passphrases. This may be us deciding to capitalise the first letter and add a 1 on the end, as in the previous example, but could equally involve picking a colour, capitalising the last letter and adding your year of birth at the end, like: yelloW1987.

The problem with these systems is that they are not always as unique as we think and can give us a false sense of security. Here we find pitfall # 2.

## Trap 3 - Personal information

The third trap I'd like to bring to your attention is personal information. There are tools in existence to build password lists from your personal information. Including your dog's name in your passwords aids memorability, but can become predictable, especially in large groups of people.

Here we find pitfall # 3 against our goals of producing 'good' passphrases.

# Solutions & Advice

So what do we do to beat the boss and avoid the traps?

## Use a system

To achieve memorability & use-ability, we're going to need a system. Even if all passphrases are recorded on paper, a system will help us read them off and enter them in our system of choice. We must, however, be careful of traps!

We know this means avoiding complexity patterns, personal information and (perhaps most difficult) predictable/common password systems. Rather tan try and do this *every* time we set a passphrase, we should build these considerations into our system.

The following rules will help you do this.

### Length, not complexity

All systems will introduce some level of predictability, just because they're there to help you remember; a good way of countering this is using a system that also makes guessing the password with computers much harder. The goal is to use a system you'd be happy to tell an attacker, because even if they knew it, it would take them years to guess.

Maths tells us that length trumps complexity when it comes to guessing with computers, so picking long passphrases is our friend here. This does, however, depend on how the guesser is guessing and we're assuming they're guessing one character at a time.

#### Maths side-note - length & notes on guessing.

Imagine we are attackers now; we have two lists, one made up of 26 characters (all the letters in the alphabet) and one of 64 characters (all the letters plus numbers and symbols). We're going to guess 6, 8 and 10 character passwords.

Attacking character by character requires (number of characters)^(length) guesses. Our 6 character password takes ~308 million guesses with the small character set and ~68 billion with the bigger one. You'd go with more characters right?

Well an 8 character password takes 208 billion guesses (26 chars) and 281 trillion (64 chars); a 10 character password takes 141 trillion guesses (26 chars) and 1 million trillion.

So what does this mean? Well we need to consider what kind of attacks our system is vulnerable to and protect accordingly. If we use dictionary words, *our dictionary must have enough words in it* to make guessing prohibitive.

*Remember this - how many things to choose from N & how many of them to guess L. The effort to crack it is like N^L.* (GRAPH)

### Be a Machine

Machines are good at getting rid of problems around predictability. If you choose to use a  word based password, machines can randomly pick words from a bit pool (solving our last problem); if you choose to use random characters, they can randomise a long set of those too.

{% include figure image_path="/assets/images/posts/password_level_1/machine.jpg" alt="Machine Generation" caption="Using machines to generate passphrases can help up bypass most of the pitfalls we identified at the start." %}

This creates problems with remembering passphrases, which we'll cover in later parts of this series (Don't panic!).

### It's what you do with it that counts

As well as picking a good passphrase, we need to protect it. We must limit its reuse, keep it to ourselves and store it carefully.

For most people, getting into securing their passwords, re-use is the biggest problem no one wants to talk about. I'll be tackling this later on in the series, don't panic, I have an idea!

# Examples

That's all well and good, but what should you actually do? Well in the interest of being hard-to-guess, I'm going to encourage you to pick your own passphrase system; it may help, however, to look at some available systems, which you could use, modify or ignore at your leisure.

## Three Words

A popular piece of guidance at the moment is to use the UK National Cyber Security Centre's [three words guidance](https://www.ncsc.gov.uk/blog-post/three-random-words-or-thinkrandom-0?page=1); this provides a turn-key solution you can use, which provides a compromise - very good memorability, but still hard to guess.

The traps for this method can be the number of words in your word pool and the randomness they're picked with. I recommend using a random work generator for this method. You should also consider capitalisation, spaces and special characters and whether you'll work these in for when you're forced to use them.

An additional piece of advice on this is that three words can be used with memory techniques, like making a picture of your passphrase, to make it more memorable. I generated three random words online -

*lions fuel bland*

To help me remember this phrase, I could imagine lions drinking fuel and finding the whole thing a bit bland. **If it's stupid but it works, it's not stupid.**

## Three Words +

If you want something more secure than the three words approach, you may consider a longer passphrase; this is similar to the three words approach, but can be extended to use a greater number of random words, with filler words between if you like. An example would be, five random words - lion fuel bland cluster crazy - which could be turned into a complex sentence, like -

**lions fuel up a bland cluster of 6 crafty corvettes.**

These passphrases are long, have added complexity in your filler words and have the option to include numbers and special characters, as makes sense for your passphrase. This doesn't offer much over the three words approach in terms of memorability, but does in added complexity. I would say this one is for the paranoid.

You may have issues, however, with complexity requirements and length limits for this kind of passphrase - so read on!


A good rule of thumb I go by, is that if it's a complex, random passphrase, I'm comfortable with above 15 characters, but always go for as long as bearable; if it's a sentence based system, three words is an absolute minimum, even with very good randomness.

## Truncated words

The longer sentences approach can be modified to something I call truncated words approach. This is the same as the above, only you select some of the letters from each word to use as your passphrase. In the example above, the passphrase:

**lions fuel up a bland cluster of 6 crafty corvettes**

Could be truncated; the simplest truncation would be the first letter, but let's use the first two. I'll add complexity by capitalising the first letter too.

**LiFuUpABlClOf6CrCo**

This passphrase looks random, will fit many length limits, but has the same degree of memorability as the full phrase, provided the truncation system is easy to remember and use.

Downfalls with this method are a degree of predictability if your truncation system is public, as well as a reduced usability over just the longer phrase itself. This one is good if you have complexity requirements that your full phrase can't meet too.

# A final note on attacks

Now is a good time to call your mind back to part 1, understanding how attacks happen. Now your head is in the right place, consider that attackers will often carry out attacks, first with commonly used passwords (from some pre-built list), then simple passwords based off a dictionary they produce (or buy etc.), these will start with limited complexity from capitalisation and letter substitution (think a+>@), before becoming more complex, before finally a full-blown 'brute force' attack takes place (this is the aaa, aab, aba, abb guessing scheme).

Now as you go forward, it should be clear, avoid common passwords, avoid words likely to be in a dictionary, then avoid single words, with complexity added in, then make passwords computationally hard to guess.

# building your first password

So, now you have an idea of some possible systems and hopefully you have an idea of what systems suit you. **Let's make a passphrase**.

![Just DO IT](/assets/images/posts/password_level_1/do_it.gif)

We're not going to use machine generation here, because I need to remember this passphrase easily; it's one I'll use to protect my most valuable account too, so I'm going to make it of a good strength.

## Pick a scheme

Decide which kind of scheme you'd like to use; if you need to, note this down somewhere safe.

I'll be using Three Words + for this passphrase.

## Length (again)

Decide on the length requirement you'll go for; I like at least 15 characters if you're going for characters, or at least 3 words if going for a phrase.

I'm really keen to protect this account so I'm going to aim for 5 words in my passphrase.

## Get random seed

Whether you're using words or characters, google an online generator now and get some!

I generated the following using [onlinewordgenerator](https://randomwordgenerator.com/):

*decorative legislation brick joy housewife*

## does it make a picture?

Use some good memory aides, make a picture, tell a story, whatever works for you; you may wish to record this along with your passphrase.

I'm going to make a picture of a bit of legislation hung on a wall, while a brick brings great joy to a housewife.

Stupid, but it works for me.

## Check yo self

Make sure it makes sense, are there too many details personal to you? Is it predictable? Does it have too simple elements Is it long enough? Will the service or site you're putting it in accept its length and complexity?

My passphrase doesn't meet the complexity requirements for the system it's going in to; I'm already happy that it's adequately secure, so I'll add a special character and a number in a memorable, but non-standard way.

*decorative legislation < brick joy 2 housewife*

This also changes my memory story - now decorative legislation is less than brick-joy to a housewife.

## It's ready!

Now I have my passphrase, I'm going to remove the space characters, since I don't need them and I have:

*decorativelegislation<brickjoy2housewife*

Even for paranoid ol' me, I'm happy with the complexity & randomness, it's not related to my personal life and it's not an overly predictable system.

## Record this - look forward

in a way that makes sense to you; I'm going to assume you're a 'normal person' (whatever that means), so we'll write it down, with a view to storing it securely in a safe or hidden location, maybe just until we remember it.

The next part of this series will touch on this more; we need to think about it carefully, so we'll come back to it again.

# Now what?

Watch out for the next post - Password Kung Fu Level 2 - where you'll take your credential journey on to the next stage; we'll be adding usability, simplicity and automation to your life. Imagine if you could **stop having to remember all those passwords**, well that's where we're going!
