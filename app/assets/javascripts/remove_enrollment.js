$(document).ready(function() {
  $('.material-icons.delete-enrollment').on('click', function(event) {
    event.stopPropagation();
    event.preventDefault();
    var buttonClicked = event.target
    if (window.confirm('Are you sure?')) {
      ajaxEnrollmentDelete(buttonClicked);
    }
  });

  $('a.btn.waves-effect.waves-light.red.delete-enrollment').on('click', function(event) {
    event.stopPropagation();
    event.preventDefault();
    var buttonClicked = event.target
    if (window.confirm('Are you sure?')) {
      ajaxEnrollmentDelete(buttonClicked);
    }
  });

});

var ajaxEnrollmentDelete = function(buttonClicked) {
  var enrollmentClass = $($(buttonClicked).closest('tr')[0]).attr('class');
  var enrollmentId = enrollmentClass.match(/enrollment-(\d+)/)[1];
  var request = $.ajax({
    method: 'DELETE',
    url: '/api/v1/enrollments/' + enrollmentId
  });

  request.success(function(data) {
    console.log(data.result);
    $($(buttonClicked).closest('tr')[0]).remove();
  });
};
