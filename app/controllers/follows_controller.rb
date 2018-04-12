# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Link Zone is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class FollowsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
  end
  def add_friend
     @user = User.find(params[:user_id])
     current_user.friend_request(@user)
  end
  def delete_friend
     @user = User.find(params[:user_id])
     puts "================"
     puts @user.id
     current_user.remove_friend(@user)
  end
  def accept_friend
     @user = User.find(params[:user_id])
     current_user.accept_request(@user)
  end
  def decline_friend
     @user = User.find(params[:user_id])
     current_user.decline_request(@user)
  end
  def block_friend
     @user = User.find(params[:user_id])
     current_user.block_friend(@user)
  end

    def unblock_friend
     @user = User.find(params[:user_id])
     current_user.unblock_friend(@user)
  end
end
