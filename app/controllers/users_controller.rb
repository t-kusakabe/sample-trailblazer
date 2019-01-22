class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @teachers = Teacher.all
    @form = Users::Contract::Create.new(User.new)
  end

  def create
    user_params = params.require(:user).permit(:teacher_id, :name)
    result = Users::Operation::Create.call(user_params)

    if result['validation_errors'].present?
      @teachers = Teacher.all
      @form = result['contract']
      flash[:error] = translate_validation_errors(result)
      render 'new'
    else
      redirect_to users_path, flash: { notice: 'User を作成しました。' }
    end
  end
end
