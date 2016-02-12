$(function() {

  Highcharts.setOptions({
   colors: ['#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
  });

  $.get("/activity", function(response) {

    for (var i=0; i < response.length; i++) {
      response[i].name = response[i].activity
      response[i].y = response[i].number
    }

    $("#chart-container-activity").highcharts({
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
        text: "Activity"
      },
      series: [{
        name: "Activity",
        data: response
      }]
    });
  });
});
