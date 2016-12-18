$(document).ready(function() {
    var myData = [];
    $.getJSON("/metrics", {}, function(data) {
        myData = data;
    });

    //draw the graph
    var graph = function() {
        //console.log(myData);
        //myData should be retrieve from the bdd but it doesn't work so we use a metrics test to display a graph with d3
        var test = [{x: "20/10/2016", y: 5}, {x: "25/10/2016", y : 2}, {x:"28/10/2016", y: 8}, {x:"02/11/2016", y: 9}, {x:"10/11/2016", y: 0}];
        var data = {
          name: 'Data',
          values: test
        };
        var lc = new LineChart({
          parent: '#myMetrics',
        	x_parse: d3.time.format("%d/%m/%Y").parse,
        	x_scale: d3.time.scale(),
        	all_series: [data]
        });
        lc.plot();
    }

    $('#show-metrics').click(function(e) {
      e.preventDefault();
      graph();
      $('#show-metrics').prop("disabled",true);
    });
});
