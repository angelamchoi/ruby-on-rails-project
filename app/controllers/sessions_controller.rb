class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
      # log the user in and redirect to the user's show page
    else
      # create an error message
      flash.now[:danger] = '    Invalid email/password combo'
      render 'new'
    end
  end

  def destroy
  end
end
