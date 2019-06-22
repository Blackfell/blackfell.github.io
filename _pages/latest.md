---
permalink: "/latest/"
layout: default

---

{% for post in site.posts limit:1 %}
  {{post | replace: "<!doctype html>", "" | replace: "\<nav", "" }}
  {{post.masthead}}
  {{post.content}}
{%endfor%}
