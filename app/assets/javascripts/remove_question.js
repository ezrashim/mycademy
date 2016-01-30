$(document).ready(function() {
  $('.material-icons.delete-question').on('click', function(event) {
    event.stopPropagation();
    event.preventDefault();
    var buttonClicked = event.target
    var question = $('.card-panel.hoverable.question')
    if (window.confirm("really?")) {
      ajaxQuestionDelete(buttonClicked);
    }
  });
});

var ajaxQuestionDelete = function(buttonClicked) {
  var questionClass = $($(buttonClicked).closest('row')[0]).attr('class')
  var questionId = questionClass.match(/question-(\d+)/)[1]
  var request = $.ajax({
    method: 'DELETE',
    url: '/api/v1/questions/' + questionId
  })

  request.success(function(data) {
    console.log(data.result);
    $($(buttonClicked).closest('.card-panel')[0]).remove();
  })
}
