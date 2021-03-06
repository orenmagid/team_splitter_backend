class Api::V1::UsersController < ApplicationController

  before_action :find_user, only: [:show, :update]

  def index
    @users = User.all
    render json: @users, include: ['games', 'comparisons', 'groups', 'user_groups']

  end

  def show
    render json: @user, include: ['games', 'comparisons', 'groups', 'user_groups']
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update


  end

  private

  def user_params
    params.require(:user).permit(:username, :id, :name, :height, :age)

  end

  def find_user
    @user = User.find(params[:id])

  end

end
