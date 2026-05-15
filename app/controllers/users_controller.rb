class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.order(:name)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "Usuario criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    attrs = user_params
    attrs = attrs.except(:password, :password_confirmation) if attrs[:password].blank?

    if @user.update(attrs)
      redirect_to users_path, notice: "Usuario atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: "Voce nao pode remover seu proprio usuario."
    else
      @user.destroy
      redirect_to users_path, notice: "Usuario removido com sucesso."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
