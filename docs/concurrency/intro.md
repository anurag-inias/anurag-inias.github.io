# Concurrency

[source](https://www.manning.com/books/grokking-concurrency)

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
</script>

## Latency vs. Throughput

- Latency is a measure of how long a single task takes from start to finish.
- Throughput measures the number of tasks a system can handle over a period of time.

Think a bike doing multiple roundtrips to carry people between point `A` and point `B`, vs a bus doing the same. The bike has the lead in latency, but the bus will beat it with throughput advantage.

## Concurrency vs. parallelism

> "Concurrency is about **dealing with** lots of things at once. Parallelism is about **doing** lots of things at once.

- Parallelism is about multiple tasks running at the same time.
- Concurrency is multiple tasks that run in interleaving time slices. It's juggling.

## Amdahl's law

\\[
\text{speed up} = \frac{1}{(1-P) + \dfrac{P}{N}}  
\\]

where \\(P\\) is the fraction of code that can be parallelized, and \\(N\\) is the number of workers (processor cores). The code that's parallelized is split amongst the \\(N\\) cores, whereas the sequential code can only be done by a single core.

<div id="amdahl_chart"></div>

{==
Latency speedup: a given task cannot finish faster than its slowest sequential part, no matter how many cores we throw at it.
==}

## Gustafson's law

Speed up is not just latency, but also throughput. Amdahl's law assumes the work to be done as constant. But if we keep throwing larger and larger amount of work at our cores, the sequential parts will have less and less effect.

\\[
\text{speed up} = 1 + (N - 1) \times P
\\]

<div id="gustafson_chart"></div>

{==
Throughput speedup: we can do more tasks with more cores, even when individual tasks aren't finishing faster.
==}

<script type="text/javascript">
  function generateData(calculator) {
    let data = [['cores', 'P = 10%', 'P = 50%', 'P = 90%', 'P = 95%', 'P = 99%']];
    for (const c of [1, 16, 256, 16384, 65536]) {
      let row = [c];
      for (const p of [0.1, 0.5, 0.9, 0.95, 0.99]) {
        const s = calculator(p, c);
        row.push(s);
      }
      data.push(row);
    }      
    return data;
  }

  function amdahlChart() {
    var data = google.visualization.arrayToDataTable(
      generateData((p, c) => 1 / ((1 - p) + p / c))
    );

    var options = {
      title: 'Speedup vs. number of cores',
      curveType: 'function',
      legend: { position: 'bottom' },
      hAxis: {
        scaleType: 'log',
        ticks: [1, 16, 256, 4096, 16384, 65536]
      },
      vAxis: {
        viewWindow: {
          min: 0,
          max: 100
        },
        ticks: [1, 10, 20, 50, 100]
      }
    };

    const chart = new google.visualization.LineChart(document.getElementById('amdahl_chart'));
    chart.draw(data, options);
  };  
  google.charts.setOnLoadCallback(amdahlChart);


  function gustafsonChart() {
    var data = google.visualization.arrayToDataTable(
      generateData((p, c) => 1 + (c - 1) * p)
    );

    var options = {
      title: 'Speedup vs. number of cores',
      curveType: 'function',
      legend: { position: 'bottom' },
    };

    const chart = new google.visualization.LineChart(document.getElementById('gustafson_chart'));
    chart.draw(data, options);
  };
  google.charts.setOnLoadCallback(gustafsonChart);
</script>