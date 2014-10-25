$(document).ready(function(){
  $('.new_comment textarea').focus(function(){
    console.log('test');
    $(this).closest('form').find('.submitCommentBtn').removeClass('hidden');
  })
});
