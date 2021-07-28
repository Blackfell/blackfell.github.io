---
permalink: "/latest/"
classes: wide

---

{% for post in site.posts limit:1 %}
  {{post | replace: "<!doctype html>", "" | replace: 'class="masthead"', 'style="visibility:hidden; height:0px"'  }}
{%endfor%}


