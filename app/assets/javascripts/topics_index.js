$(document).ready(function(){
  // $(".topicContainer").click(function(){
  //   var link = $(this).find('.topicLink').attr('href');
  //   window.location = link;
  // });
  $('.topicActions .btn').click(function(){
    // Show form
    $(this).closest('.topicContainer').find('.commentForm').removeClass('hidden');
  });
});
