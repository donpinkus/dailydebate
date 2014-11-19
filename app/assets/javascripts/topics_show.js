function handleVoteActionBtnClick(){
  var $clickedBtn = $(this);
  var $voteActions = $clickedBtn.closest('.voteButtonsContainer');

  if (!gon.user) {
    $(this).popover({
      content: "<div>\
      <a href='/auth/facebook' class='btn btn-primary btn-block fbAuthBtn'>\
        <img src='/facebook_icon.png' height='32'>\
        sign in with <strong>facebook</strong>\
      </a>\
      <br/>\
      <p>Only 1 vote per person, <br/> so we need to know who you are.</p>\
      <p>We will <strong>never</strong> post on your wall or share your information.</p>\
      </div>",
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

  var $btns = $(this).closest('.voteButtonsContainer').find('.btn');
  var $agreeForm = $('.agreeCommentForm');
  var $disagreeForm = $('.disagreeCommentForm');

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
  var topicID = gon.topic.id;
  var isAgree = $(this).attr('data-is-agree');

  // TODO check if user exists...
  $.ajax({
    url: "/agree_vote/" + topicID + "/" + isAgree,
    method: "POST"
  }).done(function(status){
    $voteActions.find('.agreeVoteCount').text(status.agree_vote_count);
    $voteActions.find('.disagreeVoteCount').text(status.disagree_vote_count);
  });
}

function attachMixPanelTrackers(){
  // Page view
  mixpanel.track("Topic page view", { "Topic": gon.topic.title });

  // Topic voting
  // Step 1. topic button clicked.
  $('.topicAgreeBtn, .topicDisagreeBtn').click(function(){
    mixpanel.track(
      "Clicked Topic Vote",
      {
        "Is Agree": $(this).attr('data-is-agree'),
        "Topic": gon.topic.title
      }
    );
  });

  // Step 2. comment form was typed in
  $('#new_comment').submit(function(){
    mixpanel.track(
      "Submitted a comment",
      { "Topic": gon.topic.title }
    );
  });

  // Upvoted a comment
  $('#upvote').submit(function(){
    mixpanel.track(
      "Upvoted a comment",
      { "Topic": gon.topic.title }
    );
  });

  // Subscribe flow
  $('.subscribeBtn').click(function(){
    mixpanel.track(
      "Subscribe button clicked",
      { "Topic": gon.topic.title }
    );
  });

  $('#user_email').keypress(function(){
    if ($('#user_email').val().length == 0) {
      mixpanel.track(
        "Entered a name into email subscribe field",
        { "Topic": gon.topic.title }
      );
    }
  });

  $('#new_user').submit(function(){
    mixpanel.track(
      "Subscribed",
      {
        "Topic": gon.topic.title,
        "email": $('#user_email').val()
      }
    );
  });
}

$(document).ready(function(){
  attachMixPanelTrackers();

  // Topic voting
  $('.topicAgreeBtn, .topicDisagreeBtn').click(handleVoteActionBtnClick);

  // Comment voting
  $('.upvote').click(function(){
    var $vote = $(this);
    var commentID = $(this).closest('.comment').attr('data-comment-id');

    $.ajax({
      url: "/upvote/" + commentID,
      method: "POST"
    }).done(function(){
      if ($vote.hasClass('active')) {
        $vote.removeClass('active');
      } else {
        $vote.addClass('active');
      }
    });
  });

  // Subscribe
  $('.subscribeBtn').click(function(){
    // Show email input
    $('.subscribeBtn').addClass('hidden');
    $('.subscribeForm').removeClass('hidden').find('input').focus();
  });

  $('.subscribeForm').on('ajax:complete', function(){
    // Show success text.
    $('.subscribeForm').addClass('hidden');
    $('.subscribeSuccessMsg').removeClass('hidden');
  });
});
