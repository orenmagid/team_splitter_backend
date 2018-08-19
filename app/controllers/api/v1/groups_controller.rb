class Api::V1::GroupsController < ApplicationController

  before_action :find_group, only: [:show]

  def index
    @groups = Group.all
    render json: @groups, include: ['users']

  end

  def show
    render json: @group, include: ['users']
  end

  def create
    @group = Group.new(group_params)
    @user = User.find(params[:user_id])
    @group.users << @user
    if @group.save
      render json: @group, status: :accepted
    else
      render json: { errors: @group.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :id, :user_id)

  end

  def find_group
    @group = Group.find(params[:id])

  end


end
