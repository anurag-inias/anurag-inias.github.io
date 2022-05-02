---
---

A collection for random thoughts.


<!-- 

{{< tabs "sort-implementation" >}}

{{< tab "Interface" >}}
{{< highlight Java "linenos=table" >}}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}


{{< katex >}} {{< /katex >}}


{{< countsortchart.inline >}}
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart1);

  function drawChart1() {
    var data = google.visualization.arrayToDataTable([
      ['Size','Counting Sort', 'TreeMap Counting Sort', 'Quick Sort'],
      [10,897900,236500,872400],
    ]);
    data.addColumn({type: 'string', role: 'tooltip'});
    var options = {
        title: 'Counting Sort vs Quick Sort',
        curveType: 'function',
        height: 500,
        legend: { position: 'right' },
        vAxis: { title: 'Nanoseconds' },
        hAxis: { title: 'Input Size' }
      };
    var chart = new google.visualization.LineChart(document.getElementById('diagram_1'));
    chart.draw(data, options);
  }
</script>

<div id="diagram_1"></div>
{{< /countsortchart.inline >}}

-->