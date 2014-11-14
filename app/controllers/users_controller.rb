class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {success: 1}
    else
      render json: {success: 0}
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :is_subscribed)
    end
end
