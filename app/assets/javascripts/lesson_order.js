
$(document).on('click', '.arrow', function(event) {
  event.stopPropagation();
  event.preventDefault();
  var buttonClicked = event.target
  ajaxLessonOrder(buttonClicked);
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
    $section = $(data.html)
    $('.all-lessons').replaceWith($section);
  })

  // request.success(function(data) {
  //   console.log('success');
  //
  //   var lessonMove = $(buttonClicked).closest('ul')[0];
  //   var previousLesson = $(lessonMove).prev();
  //   var nextLesson = $(lessonMove).next();
  //   if (lessonDirection === "up") {
  //     if ( previousLesson.attr('class') === 'lesson' ) {
  //       $(lessonMove).detach();
  //       $(lessonMove).insertBefore(previousLesson);
  //     }
  //
  //   } else if (lessonDirection === "down") {
  //     if (nextLesson.attr('class') === 'lesson' ) {
  //       $(lessonMove).detach();
  //       $(lessonMove).insertAfter(nextLesson);
  //     }
  //   };
  // })

}
