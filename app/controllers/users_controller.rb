# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Link Zone is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user,  except: [:accept_friend_menu, :decline_friend_menu, :chat]
  before_action :check_ownership, only: [:edit, :update]
  respond_to :html, :js

  def show
    @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def deactivate
  end

  def friends
    @friends = @user.friends.paginate(page: params[:page])
  end

  def followers
    @followers = @user.user_followers.paginate(page: params[:page])
  end

  def mentionable
    render json: @user.following_users.as_json(only: [:id, :name]), root: false
  end
  def accept_friend_menu
     @user = User.find(params[:user_id])
     current_user.accept_request(@user)
     respond_to do |format|
      format.js
      #format.html { redirect_to root_path }
    end
     #redirect_to friends_user_path(current_user)
  end

    def decline_friend_menu
     @user = User.find(params[:user_id])
     current_user.decline_request(@user)
     respond_to do |format|
      #
      format.js
      #format.html { redirect_to friends_user_path(current_user) }
    end
     #redirect_to friends_user_path(current_user)
  end

  def chat
    @friends = current_user.friends
    @new_chat = Conversation.where('recipient_id = ? or sender_id = ?' ,current_user.id,current_user.id).first
    @chat_count = @new_chat.messages.where('read_status = ? and user_id NOT in (?)',false,[current_user.id]).count unless @new_chat.nil?
  end

  private

  def user_params
    params.require(:user).permit(:name, :about, :avatar, :cover,
                                 :sex, :dob, :location, :phone_number)
  end

  def check_ownership
    redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
  end

  def set_user
    @user = User.friendly.find_by(slug: params[:id]) || User.find_by(id: params[:id])
    render_404 and return unless @user
  end
end
