class UsersController < ApplicationController
  before_action :user_already_signed_in, except: [:sign_out, :show]

  def user_already_signed_in
    unless session[:current_user].nil?
      @user = User.find_by(username: session[:current_user])
      flash[:notice] = "Already signed in, sign out if you want to reconnect as another user"
      redirect_to user_path @user
      return false
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(sign_up_params)
    if @user.save
      redirect_to user_path @user
    else
      flash[:notice] = "This username is already taken, choose another one"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def sign_in
    if params[:username]
      @user = User.find_by(username: params[:username])
      unless @user.nil?
        session[:current_user] = @user.username
        redirect_to user_path @user
      else
        flash[:notice] = "Incorrect username, please try again"
        redirect_to sign_in_path
      end
    end
  end

  def sign_out
    unless session[:current_user].nil?
      session[:current_user] = nil
      redirect_to sign_in_path
    else
      flash[:notice] = "No user signed in"
      redirect_to sign_in_path
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :username, :email)
  end
end
