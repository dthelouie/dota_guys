class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
      @user = User.from_omniauth request.env['omniauth.auth']
    if @user
      @user.load_matches!(10)
      session[:user_id] = @user.id
      flash[:success] = "HEY #{@user.nickname}!")
    else
      flash[:error] = "NOT GONNA BE ABLE TO DO IT"
    end
    redirect_to root_path
  end


  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = "BYE"
    end
    redirect_to root_path
  end

end
