$(document).ready(function() {
  $.get("github-api", function(data) {
    $(".location").html(data[0].location);
    $(".following").html(data[0].following);
    $(".followers").html(data[0].followers);
    $("a[href='personalsite']").attr("href", data[0].website);
    $(".repos").html(data[0].repos);
    $(".gists").html(data[0].gists);
  });
});
