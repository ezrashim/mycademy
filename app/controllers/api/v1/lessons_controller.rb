class Api::V1::LessonsController < Api::V1::BaseController
  def update

    @lesson = Lesson.find(params[:id])


    if params[:lesson_no].present? && params[:direction] == "down"
      @next_lesson = Lesson.find_by(lesson_no: @lesson.lesson_no + 1)
      if @next_lesson.present?
        @next_lesson.increment!(:lesson_no, -1)
        @lesson.increment!(:lesson_no)

        render json: { result: "yay" }
      else
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render json: { result: "yay" }
      end
    elsif params[:lesson_no].present? && params[:direction] == "up"
      @previous_lesson = Lesson.find_by(lesson_no: @lesson.lesson_no - 1)
      if @previous_lesson.present?
        @previous_lesson.increment!(:lesson_no)
        @lesson.increment!(:lesson_no, -1)
        render json: { previous_lesson: @previous_lesson.lesson_no, lesson: @lesson.lesson_no }
      else
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render json: { result: "yay" }
      end
    end
  end
end
