$(document).ready(function(){
  $(".topicContainer").click(function(){
    var link = $(this).find('.topicLink').attr('href');
    window.location = link;
  });
});
