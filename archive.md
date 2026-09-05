---
layout: page
title: Archive
permalink: /archive/
---

<style>
  .legacy-note { padding:1rem 1.2rem; margin:0 0 1.6rem; background:#fff7f7; border-left:4px solid #b60000; border-radius:6px; font-size:.92rem; color:#5a2a2a; }
  .archive-year { margin:1.8rem 0 .4rem; font-size:1.3rem; color:#1a2233; border-bottom:1px solid #eee; padding-bottom:.2rem; }
  .archive-list { list-style:none; margin:0; padding:0; }
  .archive-list li { display:flex; justify-content:space-between; align-items:baseline; gap:1rem; padding:.45rem 0; border-bottom:1px solid #f4f4f4; }
  .archive-list a { text-decoration:none; font-weight:600; }
  .archive-list a:hover { color:#b60000; }
  .archive-list .meta { color:#8a94a6; font-size:.82rem; white-space:nowrap; }
  .archive-list .grp { display:inline-block; font-size:.68rem; text-transform:uppercase; letter-spacing:.03em; color:#b60000; background:#fbeaea; padding:.05rem .45rem; border-radius:20px; margin-left:.45rem; vertical-align:middle; }
</style>

<div class="legacy-note">
  <strong>A note on the older posts.</strong> Many of these were written years ago, as I was coming up in security.
  I've kept them here for posterity - some of it's still useful, and I think it's worth seeing where people start,
  cringe and all. Be kind. 🙂
</div>

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}
<h2 class="archive-year" id="{{ year.name }}">{{ year.name }}</h2>
<ul class="archive-list">
  {% for post in year.items %}
  <li>
    <span><a href="{{ post.url | relative_url }}">{{ post.title | default: post.slug }}</a>{% if post.group %}<span class="grp">{{ post.group }}</span>{% endif %}</span>
    <span class="meta">{{ post.date | date: "%d %b" }}</span>
  </li>
  {% endfor %}
</ul>
{% endfor %}
