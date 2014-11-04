//= require topics_index

$(document).ready(function(){
  $('.new_comment textarea').focus(function(){
    $(this).closest('form').find('.submitCommentBtn').removeClass('hidden');
  })

  // Voting
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

});
