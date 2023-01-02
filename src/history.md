---
layout: default
exclude_from_search: true
---
<script
  type="text/javascript"
  src="https://unpkg.com/vis-timeline@latest/standalone/umd/vis-timeline-graph2d.min.js"
></script>

<script>
  var items = [
    {% for event in collections.events.resources -%}
      {
      {% for item in event.data.fields -%}
        "{{ item[0] }}": "{{ item[1] }}",
      {% endfor -%}
      },
    {% endfor -%}
  ]
</script>

# History timeline

This shows environmental events that occurred in Kingston, alongside significant events in the global environmental movement.

<div id="timeline" class="mt-6"></div>
