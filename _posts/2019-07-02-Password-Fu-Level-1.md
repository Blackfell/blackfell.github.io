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



In [part one](/security guidance/threats & risk/Lets-Talk-Passwords/) of this series, I explained why your account passwords are the first line of defence in your digital life. This post is the follow up, so if you're ready to take control, buckle up and enjoy.



## Level outline



The *'boss'* in this level is a collection of traps people fall into when making passwords; we'll be beating this boss together with **a passphrase worthy of greatness**, that you will generate yourself.



# The basics



This part of your training is, as with all great movie montages, all about the basics. Lucky for us, instead of hitting a punch bag for hours, or crashing bobsleighs, you get to take a shortcut at the end!



## Criteria - the answer to the basics



As mentioned in [Part 1](), passphrases must be hard to guess, unique, memorable and secret. This post is all about building the hard-to-guess and unique requirements without the usual problem of this conflicting with easy-to-remember too much.



This is, unfortunately for us, always a compromise; any help for your memory is a help for your attacker. At some point however, even if you write your passwords somewhere safe (as we'll discus in later parts), you'll need to remember a passphrase at some point in your life; chances are this memorised passphrase will be significant and may even be your most important one (cough – later posts), so we're going to cover this topic first.



# Pitfalls



To set us up for this, let's cover pitfalls people often fall into.



## Requirements



Password requirements from sites and systems can be the bain of strong passwords. Encouraging a formulaic combination of character types has a tendency to get humans to produce formulaic passphrases. If the requirement is a mix of upper-case, lower-casea dn numbers, someone who dreams up the passphrase flower, will have a tendency to change it to Flower1, or some similar derivative.

By the time a whole population does this, the patterns can be quite common; so we find pitfall #1.



## Predictable Systems



Related to pitfall #1 is predictable systems; this occurs where we users deisng a password system to get around the difficulties of picking and remembering passphrases. This may be us deciding to capitalise the first letter and add a 1 on the end, as in the previous example, but could equally involve picking a colour, capitalising the last letter and adding your year of birth at the end, like: yelloW1987.



The problem with these systems is that they are not always as unique as we think and can give us a false sense of security. Here we find pitfall #2.



## Personal information



The third pitfall I'd like to bring to your attention is personal information. There are tools in existence to build password lists from your personal information. Including your dog's name in your passwords aids memorability, but can become predictable, especially in large groups of people.

Here we find pitfall #3 against our goals of producing 'good' passphrases.



# Advice



So what do we do about these pitfalls?



## Use a system that avoids pitfalls by design



To achieve memorability & use ability, we're going to need a system. Even if all passphrases are recorded on paper, a system will help us read them off and enter them in our system of choice. We must, however, be careful!



To do this, we need to avoid complexity patters, avoid personal information and (perhaps most difficult) avoid predictable password systems.



## Length, not complexity



All systems will introduce some level of predictability, because by their nature they're there to help you remember; a good way of countering this is using a system that also makes guessing the password much much harder, from a computational perspective. Think of this as a remembering system you'd be happy to tell an attacker because even if they knew it, it would take them years to guess.



Maths tells us that length trumps complexity when it comes to guessing with computers, so picking long passphrases is our friend here. This does, however, depend on how the guesser is guessing and we're assuming they're guessing one character at a time.





### Maths sidenote - why length? Notes on guessing.



Assume you pick passwords from a dictionary of 100000 words. Attackers have very different problems if they guess character by character (Diag of aaa aab aba abb), or use their own dictionary to guess full words. At teh end of the day, if you use words, attackers also have access to your language and can do this just fine.



Attacking character by character, an attacker may choose to use a 64 character set (letters, caps, numbers and symbols); his is 64^6 = lots, but if it's a dictionary guess, it's only te 100000 guesses in our dictionary.



So what does this mean? Well we need to consider what kind of attacks our system is vulnerable to and protect accordingly. If we use dictionary words, *our dictionary must have enough words in it* to make guessing prohibitive.



*Remember this - how many things to choose from N & how many of them to guess L. The effort to crack it is like N^L.* (GRAPH)

## Be a Machine



Machines are good at getting rid of problems around predictability. If you choose to usea  word based password, machines can randomly pick words from a bit pool (solving our last problem); if you choose to use random characters, they can randomise a long set of those too.



This creates problems with remembering passphrases, which we'll cover in later parts of this series (Don't panic!).



## It's what you do with it that counts



As well as picking a good passphrase, we need to protect it. We must limit its reuse, keep it to ourselves and store it carefully.



For most people, getting into securing their passwords, re-use is the biggest problem noone wants to talk about. I'll be tackling this later on in teh series, don't panic, I have an idea!



# Examples



That's all well and good, but what should you actually do? Well in the interest of being hard-to-guess, I'm going to encourage you to pick your own passphrase system; it may help, however, to look at some available systems, which you could use, modify or ignore at your leisure.



## three words - use passphrases



A popular piece of guidance at the moment is to use the UK National Cyber Security Centre's [three words guidance](https://www.ncsc.gov.uk/blog-post/three-random-words-or-thinkrandom-0?page=1); this provides a turn-key solution you can use, which provides a compromise - very good memorability, but still hard to guess.



The pitfalls for this method can be the number of words in your word pool and the randomness they're picked with. I recommend using a random work generator for this method. You should also consider capitalisation, spaces adn special characters and whether you'll work these in for when you're forced to use them.



An additional piece of advice on this is that three words can be used with memory techniques, like making a picture of your passphrase, to make it more meorable. I generated three randowm words online - Shaman Cannibalism Magnet - To help me remember this phrase, I could imagine a Shaman, who moves to different villages, but can't help attracting cannibalism.



## Longer Sentences



If you want something more secure than the three words approach, you may consider a longer passphrase; this is similar to the three words approach, but can be extended to use a greater number of randomw words, with filler words between if you like. An example woudl be, five randowm words - lion fuel bland cluster crazy - which could be turned into a complex sentence, like - lions fuel up a bland cluster of 6 crafty corvettes.



These passphrases are long, have added complexity in your filler words and have the option to include numbers and special characters, as makes sense for your passphrase. This doesn't offer much over the three words approach in terms of memorability, but does in added complexity. I would say this one is for the paranoid.



You may have issues, however, with complexity requirements and length limits for this kind of passphrase - so read on!



## Truncated words



The longer sentences approach can be modified to something I call truncated words approach. This is the same as the above, only you select some of the letters from each word to use as your passphrase. In teh example above, the passphrase:



**lions fuel up a bland cluster of 6 crafty corvettes**



Could be truncated; the simplest truncation would be the first letter, but let's use the first two. I'll add complexity by capitalising the first letter too.



**LiFuUpABlClOf6CrCo**



This passphrase looks random, will fit many length limits, but has the same degree of memorability as the full phrase, provided teh truncation system is easy to remember and use.



Downfalls with this method are a degree of predictability if your truncation system is public, as well as a reduced usability over jus tthe longer phrase itself. This one is good if you have complexity requirements that your full phrase can't meet too.



# A final note on attacks



Now is a good time to call your mind back to part 1, understanding how attacks happen. Now your head is in teh righ place, consider that attackers will often carry out attacks, first with commonly used passwords (from some pre-built list), then simple passwords based off a dictionary they produce (or buy etc.), these will start with limited complexity from capitalisation and letter substitution (think a+>@), before becoming more complex, before finally a full-blown 'brute force' attack takes place (thi is the aaa, aab, aba, abb guessing scheme).



Now as you go forward, it should be clear, avoid common passwords, avoid words likely to be in a dictionary, then avoid single words, with complexity added in, then make passwords computationally hard to guess.



# building your first password



So, now you have an idea of some possible systems, let make one.



## Be more Shia - just DO It



We're not going to use machine generation here unless you really think you want it; this password is one you'll need to use regularly, it needs to protect your most valuable account and you need to be able to record and remember it.



### Pick a shceme



Decide which kind of scheme you'd like to use; if you need to, note this down somewhere safe.



### Length (again)



A good rule of thumb I go by, is that if it's a complex, random passphrase, I'm comfortable with above 15 characters, but always go for as long as bearable; if it's a sentence based system, three words is an absolute minimum, even with very good randomness.

### Get random seed - word generator



If you're using words, go to your online generator now and get some!



### does it make a picture?



Use some good memory aides, make a picture, tell a story, whatever works for you; you may wish to record this along with your passphrase.



## Check yo self - sanity check generation



Make sure it makes sense, are there too many details personal to you? Is it predictable? Does it have too simpple elements Is it long enough?



### Record this - look forward



in a way that makes sense to yourself If you are on the run from MI9, keeping it under your pillow might be a bad idea, but I'm going to assume you're a 'normal person' (whatever that means), so we'll write it down, with a view to storing it securely in a safe or hidden location until we remember it.



Don't worry, I'm not adding a password to your list of passwords to remember, we'll be recording this password in a safe place. Safe place means different things to different people and we'll be addressing this in this post, as well as the next part of this series (we need to think about it carefully, so we'll come back to it again).



# Now what?



## Part 2 - using this password to help your other passwords
