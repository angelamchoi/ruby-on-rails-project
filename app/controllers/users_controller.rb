class UsersController < ApplicationController #inheritance
  # before_action :logged_in_user, only: [:edit, :update]
  # before_action :correct_user, only: [:edit, :update]


  # GET /users or /users.json
  def index
    # @users = User.all 
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "   YOU'RE IN!!! :)"
      redirect_to @user
      # redirect_to user_url(@user) <-- same thing as above
    else 
      render 'new'
    end
  end

    # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # Handle successful update
        flash[:success] = "   Profile updated"
        redirect_to @user
    else
      render 'edit'
    end
  end

private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end

# Notes
# @users = asks User model to retrieve a list of all users from DB
# User.all = returns all users from the DB
# instance varaibles = variables with @sign