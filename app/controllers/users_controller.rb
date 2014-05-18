class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
  end

  def update
    respond_to do |format|
      if current_user.update!(user_params)
        format.html { redirect_to new_user_session_path, notice: 'Profile was succefffully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'profile' }
        format.json { render json: curren_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      if params[:user][:password].empty?
        params.require(:user).permit(:fullname, :email)
      else
        params.require(:user).permit(:fullname, :email, :password)
      end

    end
end
