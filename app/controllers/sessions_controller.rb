class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def subscribe
    user = User.new(params[:user])

    if user.save
      render json: {success: 1}
    else
      render json: {success: 0}
    end
  end
end
