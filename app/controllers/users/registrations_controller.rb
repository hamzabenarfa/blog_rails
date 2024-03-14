class Users::RegistrationsController < Devise::RegistrationsController
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile picture updated successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
