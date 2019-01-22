class TeachersController < ApplicationController
  def index
    if params[:name].nil?
      @teachers = Teacher.all
    else
      @teachers = Teacher.where(name: params[:name])
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @form = Teachers::Contract::Create.new(Teacher.new)
  end

  def create
    teacher_params = params.require(:teacher).permit(:name)
    result = Teachers::Operation::Create.call(teacher_params)

    if result['validation_errors'].present?
      @form = result['contract']
      flash[:error] = translate_validation_errors(result)
      render 'new'
    else
      redirect_to teachers_path, flash: { notice: 'Teacher を作成しました。' }
    end
  end

  def edit
    @form = Teachers::Contract::Update.new(Teacher.find(params[:id]))
  end

  def update
    teacher_params = params.require(:teacher).permit(:name, :id)
    teacher_params[:id] = params[:id]

    result = Teachers::Operation::Update.call(teacher_params)

    if result['validation_errors'].present?
      @form = result['contract']
      flash[:error] = translate_validation_errors(result)
      render 'edit'
    else
      redirect_to teachers_path, flash: { notice: 'Teacher を更新しました' }
    end
  end

  def destroy
    teacher_params = params.require(:teacher).permit(:id)
    
    result = Teachers::Operation::Destroy.call(teacher_params)

    if result['validation_errors'].present?
      @form = result['contract']
      redirect_to teachers_path, flash: { alert: translate_validation_errors(result) }
    else
      redirect_to teachers_path, flash: { notice: 'Teacher を削除しました。' }
    end
  end
end
