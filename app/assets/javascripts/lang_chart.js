$(function() {
  Highcharts.setOptions({
   colors: ['#564946', '#558564', '#49D49D', '#69EBD0', '#95F9E3', '#FF9655', '#FFF263', '#6AF9C4']
  });

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
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
            style: {
              color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
            }
          }
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
