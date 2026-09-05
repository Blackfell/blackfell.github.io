---
layout: page
title: Writing Elsewhere
permalink: /elsewhere/
---

<style>
  .else-cards { display:grid; grid-template-columns:repeat(auto-fill,minmax(260px,1fr)); gap:1rem; margin-top:1.2rem; }
  .else-card { display:flex; flex-direction:column; padding:1rem 1.1rem; border:1px solid #e2e6ee; border-radius:12px; background:#fff; text-decoration:none; color:inherit; box-shadow:0 1px 2px rgba(0,0,0,.04); transition:all .15s ease; }
  .else-card:hover { border-color:#b60000; transform:translateY(-3px); box-shadow:0 8px 22px rgba(182,0,0,.12); }
  .else-card h3 { margin:0 0 .3rem; font-size:1.05rem; color:#1a2233; transition:color .15s; }
  .else-card:hover h3 { color:#b60000; }
  .else-card .date { margin:0 0 .5rem; font-size:.78rem; color:#8a94a6; text-transform:uppercase; letter-spacing:.03em; }
  .else-card .excerpt { margin:0; font-size:.9rem; color:#4a5568; line-height:1.45; flex:1 1 auto; }
  .else-card .tag { display:inline-block; margin-top:.6rem; font-size:.72rem; color:#b60000; font-weight:600; }
</style>

Longer-form and professional writing I've done off this site.

{% assign items = site.data.elsewhere | sort: "date" | reverse %}
<div class="else-cards">
  {% for item in items %}
  <a class="else-card" href="{{ item.url }}" target="_blank" rel="noopener">
    <h3>{{ item.title }}</h3>
    <p class="date">{{ item.date | date: "%b %Y" }} · {{ item.outlet }}</p>
    <p class="excerpt">{{ item.description }}</p>
    <span class="tag">Read on {{ item.outlet }} ↗</span>
  </a>
  {% endfor %}
</div>
