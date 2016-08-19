class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    begin
      @user = User.from_omniauth request.env['omniauth.auth']
    rescue
      flash[:error] = "NOT GONNA BE ABLE TO DO IT"
    else
      session[:user_id] = @user.id
      flash[:success] = "HEY #{@user.nickname}!"
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
