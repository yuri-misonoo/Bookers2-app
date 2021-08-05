class MessagesController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    #if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present? 
     # @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)) 
    #end 
    #redirect_to room_path(@message.room_id) 
    #render plain: params.inspect
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.save
    @room = Room.find(@message.room_id)
    redirect_to room_path(@message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message).merge(user_id: current_user.id)
  end

end
