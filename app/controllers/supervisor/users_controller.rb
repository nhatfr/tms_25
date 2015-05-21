class Supervisor::UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        format.json {head :no_content}
        format.js
      else
        format.json {render json: @user.errors.full_messages, 
                            status: :unprocessable_entity}
      end
    end
  end
 
  def edit
  end
 
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json {head :no_content}
        format.js
      else
        format.json {render json: @user.errors.full_messages,
                                   status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @user.destroy!
    respond_to do |format|
      format.js
      format.html {redirect_to users_url}
      format.json {head :no_content}
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation, :supervisor
  end
end
