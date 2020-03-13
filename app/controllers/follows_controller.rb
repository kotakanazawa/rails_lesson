# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    follow = current_user.active_follows.build(follower_id: params[:user_id])
    follow.save
    redirect_to users_path
  end

  def destroy
    follow = current_user.active_follows.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to users_path
  end
end
