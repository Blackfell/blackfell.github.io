---
permalink: "/latest/"
layout: default

---

{% for post in site.posts limit:1 %}
  {{post.body }}
  {{post | replace: "<!doctype html>", "" | replace: "\<nav", "" }}
{%endfor%}
