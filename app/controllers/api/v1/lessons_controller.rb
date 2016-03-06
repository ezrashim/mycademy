class Api::V1::LessonsController < Api::V1::BaseController

  def update
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
    @enrollment = Enrollment.find_by(role: "leader", course: @course)
    @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }

    if params[:direction].present? && params[:direction] == "down"
      @next_lesson = Lesson.find_by(lesson_no: @lesson.lesson_no + 1, course: @course)
      if @next_lesson.present?
        @next_lesson.increment!(:lesson_no, -1)
        @lesson.increment!(:lesson_no)
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render json: { html: render_to_string( partial: 'courses/lessons', layout: false, locals: { lessons: @lessons }) }
      else
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render json: { html: render_to_string( partial: 'courses/lessons', layout: false, locals: { lessons: @lessons }) }
      end
    elsif params[:direction].present? && params[:direction] == "up"
      @previous_lesson = Lesson.find_by(lesson_no: @lesson.lesson_no - 1, course: @course)
      if @previous_lesson.present?
        @previous_lesson.increment!(:lesson_no)
        @lesson.increment!(:lesson_no, -1)
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render json: { html: render_to_string( partial: 'courses/lessons', layout: false, locals: { lessons: @lessons }) }
      else
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render json: { html: render_to_string( partial: 'courses/lessons', layout: false, locals: { lessons: @lessons }) }
      end
    end
  end
end
