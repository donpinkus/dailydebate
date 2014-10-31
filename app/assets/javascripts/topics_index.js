$(document).ready(function(){
  // $(".topicContainer").click(function(){
  //   var link = $(this).find('.topicLink').attr('href');
  //   window.location = link;
  // });
  $('.topicActions .btn').click(function(){
    if (!gon.user) {
      $(this).popover({
        content: "<div>\
        <p>We only allow 1 vote per person on an opinion, <br/> so we need to know who you are!</p>\
        <a href='/auth/facebook' class='btn btn-primary'>sign in with facebook</button></div>",
        html: "true",
        placement: "bottom",
        title: "log in to vote"
      }).on("show.bs.popover", function(e){
        // hide all other popovers
        $("[rel=popover]").not(e.target).popover("destroy");
        $(".popover").remove();
      });

      $(this).popover('toggle');

      return false;
    }

    var $btns = $(this).closest('.topicActions').find('.btn');
    var $agreeForm = $(this).closest('.topicContainer').find('.agreeCommentForm');
    var $disagreeForm = $(this).closest('.topicContainer').find('.disagreeCommentForm');

    if ($(this).hasClass('active')) {
      $btns.removeClass('active');
      $agreeForm.addClass('hidden');
      $disagreeForm.addClass('hidden');
    } else {
      $btns.removeClass('active');
      $agreeForm.addClass('hidden');
      $disagreeForm.addClass('hidden');

      $(this).addClass('active');
      if ($(this).attr('data-is-agree') == 1) {
        $agreeForm.removeClass('hidden');
      } else {
        $disagreeForm.removeClass('hidden');
      }

    }

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

  });
});

// hsl(88, 50%, 54%)

// hsl(103, 100%, 84%)
