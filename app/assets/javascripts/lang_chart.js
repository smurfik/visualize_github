$(function() {
  $.get("/lang-chart", function(response) {

    for (var i=0; i < response.length; i++) {
      response[i].name = response[i].language
      response[i].y = response[i].repos
    }

    $("#chart-container").highcharts({
      chart: {
        type: "pie",
        plotShadow: true
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer'
        }
      },
      title: {
        text: "Languages Used In Your Projects"
      },
      series: [{
        name: "Languages Used",
        data: response
      }]
    });
  });
});
