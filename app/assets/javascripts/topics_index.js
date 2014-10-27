$(document).ready(function(){
  // $(".topicContainer").click(function(){
  //   var link = $(this).find('.topicLink').attr('href');
  //   window.location = link;
  // });
  $('.topicActions .btn').click(function(){
    $(this).addClass('active');

    // Submit Ajax vote
    var topicID = $(this).closest('.topicContainer').attr('data-topic-id');
    var isAgree = $(this).attr('data-is-agree');

    // TODO check if user exists...
    $.ajax({
      url: "/agree_vote/" + topicID + "/" + isAgree,
      method: "POST"
    }).done(function(status){
      console.log(status);
      console.log('voted');
    });

    // Show form
    $(this).closest('.topicContainer').find('.commentForm').removeClass('hidden');
  });
});

// hsl(88, 50%, 54%)

// hsl(103, 100%, 84%)
