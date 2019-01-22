class TeachersController < ApplicationController
  def index; end

  def new
    @form = Teachers::Contract::Create.new(Teracher.new)
  end

  def create
    teacher_params = params.require(:teacher).permit(:name)
    result = Teachers::Operation::Create.call(teacher_params)

    if result['validation_errors'].present?
      @form = result['contract']
      flash[:error] = translate_validation_errors(result)
      render 'new'
    else
      redirect_to teachers_path, flash: { notice: 'Teacherを作成しました' }
    end
  end
end