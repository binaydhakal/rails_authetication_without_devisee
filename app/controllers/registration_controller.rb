class RegistrationController < ApplicationController
  # validates :password, { length: {minimum:5, maximum:10} }

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
      redirect_to root_path, notice: "Successfully Created Account."
    else 
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end