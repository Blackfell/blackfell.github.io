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

In this level, you'll be coming up with **a passphrase worthy of greatness**, which you'll generate manually and use  again as you move on to future posts, watch this space!

As mentioned in [Part 1](/security guidance/threats & risk/Lets-Talk-Passwords/), passphrases must be **hard to guess, unique, memorable and secret**. This post is all about building a passphrase that meets these requirements, without falling into some common traps.

![It's a trap](/assets/images/posts/password_level_1/trap.gif)

## Trap 1 - Complexity Requirements

Password requirements from sites and systems often encourage a formulaic combination of character types; the problem is, this has a tendency to get us users to produce formulaic passphrases.

If a website requires a mix of upper-case, lower-case and numbers, it's no wonder that we users come up with patterns like turning *'flower*' info *'Flower1'*, or some similar derivative. This doesn't make things weaker, but we should be careful that it doesn't give us a false sense of security.

## Trap 2 - Predictable Systems

In addition to clever systems to meet complexity needs, we users sometimes pick password systems to help us remember passphrases. This is the *clever trick* that you might use in all your passphrases, like starting them with the number 7, or finishing them all with your year of birth.

The problem with these systems is that they are not always as unique as we think and if a passphrase gets leaked in an online breach, your system could be discovered and used to guess other credentials.

## Trap 3 - Personal information

The third trap I'd like to bring to your attention is personal information. There are tools in existence to build password lists from your personal information, which are scarily effective if fed some basics about you.

Including your dog's name in your passwords aids memorability, but can be predicted, even if you add complexity around it. Just trust me on this, avoid it.

# Our Solution - Use a system

So what do we do to avoid the traps without having to remember crazy passphrases?

To achieve memorability & use-ability, we're going to need a system. We must, however, be careful of traps! We know this means avoiding complexity patterns, personal information and (perhaps most difficult) predictability. Rather tan try and do this *every* time we set a passphrase, we should build these considerations into our system.

The following rules will help you do this.

## Length, not complexity

Even though complexity is good, we shouldn't get hung up on it; length can outstrip complexity pretty quickly! Picking longer passphrases will make guessing the password with computers difficult.

A simple way of remembering this is **passphrases not passwords**; this way of thinking gets us in a mindset to make much longer credentials and avoid things like single words.

### Maths side-note (for the nerdy)

Imagine we are attackers now; we have two lists, one made up of 26 characters (all the letters in the alphabet) and one of 64 characters (all the letters plus numbers and symbols). Two innocent users make passwords (Suzan and Angela); the passwords are both 6 characters long.   Suzan uses the alphabet characters and Angela uses the special character set. Suzan gets *'lodieb'* and Angela gets *'i&H3pS'*.

Attacking character by character requires (number of characters)^(length) guesses. Suzan's 6 character password takes ~308 million guesses with the small character set and Angela's takes ~68 billion with the bigger one. Angela's way is better, right?

Well yes, more characters does make guessing harder, but it also makes remembering harder; switching Suzan's basic alphabet passphrase from 6 to 8 characters boosts her 308 Million to 208 billion guesses so she can get just as much complexity as Angela (actually a bit more) by adding a couple of letters on the end. Suzan now has *'lodiebam'*.

So what does this mean? Well in terms of memorability, large and complex character sets can be a hindrance and just making our passphrases longer would mean we wouldn't really need them as much. Practically the difference is between remembering something like *'i&H3pS'* and *'lodiebam'*.

## Be a Machine

{% include figure image_path="/assets/images/posts/password_level_1/machine.jpg" alt="Machine Generation" caption="Using machines to generate passphrases can help up bypass most of the pitfalls we identified at the start." %}

Machines are good at getting rid of problems around predictability. Machines can help us build in some randomness (solving our last problem), this can, however, create problems with remembering passphrases, but we'll come on to that.

## It's what you do with it that counts

As well as picking a good passphrase, we need to protect it. We must limit its reuse, keep it to ourselves and store it carefully.

For most people, getting into securing their passwords, re-use is the biggest problem no one wants to talk about. I'll be tackling this later on in the series, don't panic, I have an idea!

# Examples

So we have some advice, which is all well and good, but what should you actually do? Well in the interest of being hard-to-guess, I'm going to encourage you to pick your own passphrase system; it may help, however, to look at some available systems, which you could use, modify or ignore at your leisure.

## Three Words

A popular piece of guidance at the moment is to use the UK National Cyber Security Centre's [three words guidance](https://www.ncsc.gov.uk/blog-post/three-random-words-or-thinkrandom-0?page=1); this provides a turn-key solution you can use, which provides a compromise - very good memorability, but still hard to guess.

The traps for this method can be the number of words in your word pool and the randomness they're picked with. I recommend using a random work generator for this method. You should also consider capitalisation, spaces and special characters and whether you'll work these in for when you're forced to use them.

An additional piece of advice on this is that three words can be used with memory techniques, like making a picture of your passphrase, to make it more memorable. I generated three random words online -

> rational carrot challenge

To help me remember this phrase, I could imagine a load of nerdy carrots in a competition to see who's got the Best logic. **If it's stupid but it works, it's not stupid.**

## Three Words +

If you want something more secure than the three words approach, you may consider a longer passphrase; this is similar to the three words approach, but can be extended to use a greater number of random words, with filler words between if you like. An example would be extending out Three words out to five random words - rational carrot challenge slump baby - which could be turned into a complex sentence (don't change it too much, or you lose the randomness factor), like -

> Rational carrots challenge 4 babies to slump.

These passphrases are long, have added complexity in your filler words and have the option to include numbers and special characters, as makes sense for your passphrase. This doesn't offer much over the three words approach in terms of memorability, but does add complexity. I would say this one is for the paranoid.

You may have issues, however, with complexity requirements and length limits for this kind of passphrase - so read on!


## Truncated words

The longer sentences approach can be modified to something I call truncated words approach. This is the same as the above, only you select some of the letters from each word to use as your passphrase. In the example above, the passphrase:

> Rational carrots challenge 4 babies to slump.

Could be truncated; the simplest truncation would be the first letter, but let's use the first two. I'll add complexity by capitalising the first letter too.

> RaCaCh4Ba2Sl

But why would we use this system? The main reason is that this is much shorter than the word based approach, some sites and services have short length limits, or maybe you can't reliably type a passphrase that long (I'm looking at you hunt 'n' peck typers). This passphrase has nearly the same degree of memorability as the full phrase, provided the truncation system is easy to remember and use.

Downfalls with this method are a degree of predictability if your truncation system is public, as well as a reduced usability over just the longer phrase itself. This one is good if you have complexity requirements that your full phrase can't meet too.

# A final note on attacks

Now is a good time to call your mind back to [part one](/security guidance/threats & risk/Lets-Talk-Passwords/), where we discussed how attacks happen; take another minute to consider how you'll be attacked before you settle on your final passphrase system.

Attackers will often carry out attacks, first with commonly used passwords (from some pre-built list), then simple passwords based off a dictionary they produce (or buy etc.), ramping up the complexity of their guesses from capitalisation and letter substitution (password becomes Password, then Password1 then P@ssw0rd1 etc.), before finally a full-blown 'brute force' attack takes place (this is the aaa, aab, aba, abb guessing scheme).

You may also find more attackers starting to try word combination attacks alongside dictionary attacks, where attackers use big word lists to guess against systems like our 'Three Words' idea. Whilst this isn't overly popular now, guidance on three-words-like systems is becoming widespread and we can expect to see this develop in future.

Take this opportunity to double check your system; if you're building out a system based on characters (not words), you need to push that length out, exceed 15 characters if you can, as many as you can manage. If you're going on a word based system, remember that regardless of the numbers, symbols and so on that you add in to the mix, you need at least three randomly generated words in there from a *big pool* or words to give you complexity; use an online generator and if you can, push your word count up nearer 5.

# building your first password

So, now you have an idea of some possible systems and hopefully you have an idea of what systems suit you. **Let's make a passphrase**.

![Just DO IT](/assets/images/posts/password_level_1/do_it.gif)

I need to remember this passphrase easily, it's one I'll use to protect my most valuable account too, so I'm going to make it of a good strength. Let's go!

## Pick a scheme

Decide which kind of scheme you'd like to use; if you need to, note this down somewhere safe.

I'll be using Three Words + for this passphrase.

## Length (again)

Decide on the length requirement you'll go for; I like at least 15 characters if you're going for characters, or at least 3 words if going for a phrase.

I'm really keen to protect this account so I'm going to aim for 5 words in my passphrase.

## Get random seed

Whether you're using words or characters, google an online generator now and get some!

I generated the following using [onlinewordgenerator](https://randomwordgenerator.com/):

> decorative legislation brick joy housewife

## does it make a picture?

Use some good memory aides, make a picture, tell a story, whatever works for you; you may wish to record this along with your passphrase.

I'm going to make a picture of a bit of legislation hung on a wall, while a brick brings great joy to a housewife.

Stupid, but it works for me.

## Check Yo Self

Make sure it makes sense, are there too many details personal to you? Is it predictable? Does it have too simple elements Is it long enough? Will the service or site you're putting it in accept its length and complexity?

My passphrase doesn't meet the complexity requirements for the system it's going in to; I'm already happy that it's adequately secure, so I'll add a special character and a number in a memorable, but non-standard way.

> decorative legislation < brick joy 2 housewife

This also changes my memory story - now decorative legislation is less than brick-joy to a housewife.

## It's ready!


Now I have my passphrase, I'm going to remove the space characters, since I don't need them and I have:

> decorativelegislation<brickjoy2housewife

Even for paranoid ol' me, I'm happy with the complexity & randomness, it's not related to my personal life and it's not an overly predictable system.

## Record this - look forward

in a way that makes sense to you; I'm going to assume you're a 'normal person' (whatever that means), so we'll write it down, with a view to storing it securely in a safe or hidden location, maybe just until we remember it.

The next part of this series will touch on this more; we need to think about it carefully, so we'll come back to it again.

# Now what?

![It's over](/assets/images/posts/password_level_1/bueller.gif)

Watch out for the next post - Password Kung Fu Level 2 - where you'll take your credential journey on to the next stage; we'll be adding usability, simplicity and automation to your life. Imagine if you could **stop having to remember all those passwords**, well that's where we're going!
