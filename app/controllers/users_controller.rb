class UsersController < ApplicationController
  before_action :user_already_signed_in, except: %i[sign_out show]

  def user_already_signed_in
    return if session[:current_user].nil?

    flash[:notice] = 'Already signed in, sign out if you want to reconnect as another user'
    redirect_to root_path
    false
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(sign_up_params)
    if @user.save
      session[:current_user] = @user.username
      session[:current_user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = 'This username is already taken, choose another one'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @upcoming_events = @user.attended_events.upcoming
    @previous_events = @user.attended_events.previous
  end

  def sign_in
    return unless params[:username]

    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:notice] = 'Incorrect username, please try again'
      redirect_to sign_in_path
    else
      session[:current_user] = @user.username
      session[:current_user_id] = @user.id
      redirect_to root_path
    end
  end

  def sign_out
    if session[:current_user].nil?
      flash[:notice] = 'No user signed in'
      redirect_to sign_in_path
    else
      session[:current_user] = nil
      session[:current_user_id] = nil
      redirect_to root_path
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :username, :email)
  end
end
