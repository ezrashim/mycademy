$(document).ready(function() {
  $('.material-icons.arrow').on('click', function(event) {
    event.stopPropagation();
    event.preventDefault();
    var buttonClicked = event.target
    ajaxLessonOrder(buttonClicked);

  });
});

var ajaxLessonOrder = function(buttonClicked) {
  var lessonClass = $($(buttonClicked).closest('.row')[0]).attr('class')
  var lessonDirection = $(buttonClicked).attr('class').match(/arrow-(\w+)/)[1]
  var lessonId = lessonClass.match(/lesson-(\d+)/)[1]
  var lessonNumber = lessonClass.match(/num-(\d+)/)[1]
  var request = $.ajax({
    method: 'PATCH',
    data: { direction: lessonDirection, lesson_no: lessonNumber },
    url: '/api/v1/lessons/' + lessonId
  })

  request.success(function(data) {
    console.log('success');

    var lessonMove = $(buttonClicked).closest('ul')[0];
    var previousLesson = $(lessonMove).prev();
    var nextLesson = $(lessonMove).next();
    $(lessonMove).detach();
    if (lessonDirection === "up") {
      $(lessonMove).insertBefore(previousLesson);
      var lessonElement = $($($(buttonClicked).closest('div')).find('h5')).find('a');
      var previousLessonElement = $(previousLesson).find('h5 a')[0];
      var previousLessonText = $(previousLessonElement).text().match(/\d+. (.+)/)[1]
      var lessonText = $(lessonElement).text().match(/\d+. (.+)/)[1]
      $(lessonText).text(data.lesson + '. ' + lessonText);
      $(previousLessonText).text(data.previous_lesson + '. ' + previousLessonText);

    } else if (lessonDirection === "down") {
      $(lessonMove).insertAfter(nextLesson);
    };



  })
}
