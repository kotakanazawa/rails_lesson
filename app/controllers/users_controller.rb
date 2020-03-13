# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    # TOD orderつける？
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
end
