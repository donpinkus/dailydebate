function handleVoteActionBtnClick(){
  var $clickedBtn = $(this);
  var $voteActions = $clickedBtn.closest('.voteActionsContainer');

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

  var $btns = $(this).closest('.voteActionsContainer').find('.btn');
  var $agreeForm = $(this).closest('.voteActionsContainer').find('.agreeCommentForm');
  var $disagreeForm = $(this).closest('.voteActionsContainer').find('.disagreeCommentForm');

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
  var topicID = $(this).closest('.voteActionsContainer').attr('data-topic-id');
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

$(document).ready(function(){
  $('.voteActionsContainer .btn').click(handleVoteActionBtnClick);
});
