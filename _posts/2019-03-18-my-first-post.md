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
title:  "My First Post"
date:   2019-03-18 22:22:22 +0000
header:
  overlay_image: /assets/images/generic/northern_lights.jpg
  teaser: /assets/images/generic/northern_lights.jpg
excerpt: "Hello, World!"
categories: 
  - social 
  - technical guidance
tags: 
  - jekyll 
  - web

---

# First post
This is my first ever post. This is here to say hello to all you readers, before touching briefly on how this blog is built.

{% highlight python %}
#!/usr/bin/env python
def blog():
  print("Hello, World!")
{% endhighlight %}


# What is this blog for?

This blog is designed to be all things to all people, I have guidance for friends and family (so called *normal folk*), as well as colleagues and friends who I'd consider *'security experts'*. This post is a hello to everyone, but will get technical quickly and will explain how it all works and where it's hosted.

## how does it work?

This blog is a Github Pages site, made of simple, static content; this means that there's no log in, no databases, no fancy code on my site, it just sends simple, helpful web pages to your device and the device shows them to you. Simple!

The way that developers might normally do this is by building pages from HTML, Javascript and CSS files, before putting them in a web server to show them to the world; this is what you might get taught on a web design intro course, like those excellend free courses available via [w3 academy](https://www.w3schools.com/). This site, however is built using [Jekyll](https://jekyllrb.com/), which frees me to do less design and maintenance and spend more time doing  writey blog. Great!

## What's Jekyll?
Jekyll is a framework for producing simple static websites; it's written in ruby and lets creators like me quickly pull static sites together and produce content quickly. In addition, the fantastic [Github](https://github.com/) will host your Jekyll site via [Github pages](https://pages.github.com/), probably for free (depending who you are).

### You said Framework, what's that?
Frameworks influence the whole design process of software and that's what Jekyll gives me for this blog. As a result of following Jekyll's design philosophy, I get nudged to write in a certain way, then when I'm done, Jekyll does it's stuff and turns my content in to good looking static content. 

### Does Jekyll do it all for you?
Well, no. Jekyll is great, it helps me write content in simple [Markdown](https://daringfireball.net/projects/markdown/), making my life easier, but more 'decoration' is required to get a good looking site. This is where **themes** come in. Themes are baked into how Jekyll works and I'm using [Michael Rose's](https://twitter.com/mmistakes) [minimal mistakes](https://mmistakes.github.io/minimal-mistakes/) theme.

There's more still, though; as well as markup, Jekyll lets you write dynamic content, for example, listing all blog posts on a page, using [liquid](https://jekyllrb.com/docs/liquid/). This functionality is a little trickier than writing markdown posts, but you can get loads of information at the jekyll site.

## How can I do this?
Building a site with Jekyll, Minimal Mistakes ang Github Pages has been a relatively easy and fun learning experience; if you're convinced and fancy a go, I'd reccomend starting with an overview of Jekyll via their own [documentation](https://jekyllrb.com/docs/); don't start yet though, before you get too bogged down think about picking a [theme](http://jekyllthemes.org/) if you want one. 

{% include figure image_path="/assets/images/posts/first_post/jekyll_themes.jpg" alt="Jekyll Themes screenshot" caption="Jekylltheme.org has a large selection of themes you can browse. Once you've chosen a theme you can head over to its web page and find out how best to use it." %}

Now you've picked a theme, it's time to read the documentation for that theme; this will add to your Jekyll knowledge and may actually affect the way you think about your site. If there are some base or default files for your theme, **get them now** these will invariably make your like a *lot* easier.

Now think about your design and get writing some basic content; your mileage will vary heavily here depending on your theme, but I installed Jekyll to a local machine for this part of development to get the basic site together. To host on Github Pages, make sure you use your theme **remotely**, meaning you don't download the theme locally, but include it in your Jekyll config file. 

Now you're ready to set your site up in Github Pages; there are benefits to doing this early - you'll get up and running earlier - but you're going all in and can't practice locally. It's up to you! Setting this up is really easy and all the guidance you'll need is provided on the Github Pages [how to page](https://pages.github.com/).

This will be a person/organisation site, project sites are linked to specific projects.

I create a repo called username.github.io via the github web interface.

{% include figure image_path="/assets/images/posts/first_post/git_repo.jpg" alt="git repo creation" caption="Creating a new github pages repository via the Github web interface." %}

I use a terminal client for GitHub, so I can clone and push the repo back up to Github.

1. First lets clone the repo, before copying all of the locally produced files into the new folder. There's no need to copy the *"_site"* directory created by Jekyll; remember, replace 'blackfell' for your own username.

{% highlight bash%}
git clone git@github.com:Blackfell/blackfell.github.io.git
cp ./practice_directory/* .//blackfell.github.io/
cd ./blackfell.github.io/
rm -r ./_site/
git add -A
git commit -am "First commit."
{% endhighlight %}

2. Now let's push our clean repo up to Github:

{% highlight bash%}
git push -u origin master
{% endhighlight %}

3. Profit

Your site is now gloriously live. Now go out in the world and profit!
