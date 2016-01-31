$(document).ready(function() {
  $('.material-icons.delete-question').on('click', function(event) {
    event.stopPropagation();
    event.preventDefault();
    var buttonClicked = event.target
    if (window.confirm('Are you sure?')) {
      ajaxQuestionDelete(buttonClicked);
    }
  });

  $('a.btn.waves-effect.waves-light.red.delete-question').on('click', function(event) {
    event.stopPropagation();
    event.preventDefault();
    var buttonClicked = event.target
    if (window.confirm('Are you sure?')) {
      ajaxQuestionDelete(buttonClicked);
    }
  });

});

var ajaxQuestionDelete = function(buttonClicked) {
  var questionClass = $($(buttonClicked).closest('li')[0]).attr('class');
  var questionId = questionClass.match(/question-(\d+)/)[1];
  var request = $.ajax({
    method: 'DELETE',
    url: '/api/v1/questions/' + questionId
  });

  request.success(function(data) {
    console.log(data.result);
    $($(buttonClicked).closest('.card-panel')[0]).remove();
  });
};
