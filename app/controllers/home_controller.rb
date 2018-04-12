# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Link Zone is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class HomeController < ApplicationController
  before_action :set_user, except: :front
  respond_to :html, :js

  def index
    @post = Post.new
    @friends = @user.friends.unshift(@user)
    event_friends = @user.friends
    @friends_request = current_user.requested_friends
    @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @notifications = PublicActivity::Activity.where(recipient_id: current_user.id, recipient_type: "User").where("owner_id NOT in (?) and read_status = ?",current_user.id,false).order(created_at: :desc)
    @events =  PublicActivity::Activity.where("recipient_id in (?) and trackable_type = ? and read_status = ?",event_friends.collect { |x| x.id},"Event",false).order(created_at: :desc)
    @new_chat = Conversation.where('recipient_id = ? or sender_id = ?' ,current_user.id,current_user.id).first
    @chat_count = @new_chat.messages.where('read_status = ? and user_id NOT in (?)',false,[current_user.id]).count unless @new_chat.nil?
 
   #@notifications=(@notifications << @events).flatten
  end

  def front
     @activities = PublicActivity::Activity.joins("INNER JOIN users ON activities.owner_id = users.id").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def find_friends
    @friends = @user.friends
    @users =  User.where.not(id: @friends.unshift(@user)).paginate(page: params[:page])
  end
  def mark_as_read
    
    sleep 7
  
  
   ids = params[:ids].split(',')
   #@notifications = PublicActivity::Activity.where("id in (?)",ids)
   for id in ids
   notification= PublicActivity::Activity.find(id.to_i)
   notification.update(:read_status=>true)

   end
#respond_to do |format|
 #  format.js { render :notifications => @notifications }
 #end
  end

  def mark_as_seen
   
   ids = params[:ids].split(',')
   for id in ids
   event= PublicActivity::Activity.find(id.to_i)
   event.update(:read_status=>true)
   end

  end
  private
  def set_user
    @user = current_user
  end
end
