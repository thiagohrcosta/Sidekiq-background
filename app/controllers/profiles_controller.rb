class ProfilesController < ApplicationController
  def update
    if current_user.update(user_params)
      UpdateUserJob.perform_later(current_user) 
      flash[:notice] = "Your profile has been updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end