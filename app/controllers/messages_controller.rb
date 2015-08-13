class MessagesController < ApplicationController
  include EmailNotify
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :outbox, :show]
  before_action :set_message, only: [:show, :download, :sdestroy, :destroy]
  authorize_actions_for Message
  authority_actions outbox: 'read', download: 'read', sdestroy: 'update'

  def index
    @title = 'Входящие сообщения'
    @box = 'inbox'
    @messages = current_user.messages.where(recipients: { deleted: false, user: User.current })
                .order('messages.created_at desc').page(params[:page])
    @new_messages = current_user.messages.where(recipients: { readed: false, deleted: false, user: User.current })
    render partial: 'messages/messages_table' if request.wiselinks_partial?
    session[:previous_path] = messages_path
  end

  def outbox
    @title = 'Исходящие сообщения'
    @box = 'outbox'
    @messages = Message.where(user: current_user).outbox_nodelete.includes(:recipients).order('created_at desc').page(params[:page])
    if request.wiselinks_partial?
      render partial: 'messages/messages_table'
    else
      render 'index'
    end
    session[:previous_path] = outbox_path
  end

  def new
    @title = 'Новое сообщение'
    @message = Message.new
    @logist = false
    if @user_roles.include?('logist')
      @logist = true
      users = User.with_any_role(:distributor, :logist)
      users.each do |u|
        @message.recipients.build(user: u)
      end
    else
      logist_users = User.with_role :logist
      logist_users.each do |u|
        @message.recipients.build(user: u)
      end
    end
  end

  def reply
    @title = 'Новое сообщение'
    @parent = Message.find(params[:id])
    authorize_action_for(@parent)
    @message = Message.new(parent_id: params[:id])
    @message.recipients.build(user: @parent.user)
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: 'Сообщение успешно отправлено' }
        format.json { render action: 'show', status: :created, location: @message }
        notice('new_message', message: @message)
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize_action_for(@message)
    @title = 'Сообщение'
    rm = @message.recipients.where(user_id: current_user.id).first
    unless rm.nil?
      rm.readed = true
      rm.save!
    end
  end

  def download
    path = URI.decode(@message.attachment.url)
    send_file path, x_sendfile: false
  end

  def sdestroy
    if @message.user == current_user
      @message.deleted = true
      @message.save!
    else
      rm = @message.recipients.where(user_id: current_user.id).first
      rm.deleted = true
      rm.save!
    end
    redirect_to messages_path, notice: 'Сообщение удалено'
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    current_user = User.current
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:subject, :body, :attachment, :user_id, :parent_id, recipients_attributes: [:user_id, :_destroy])
  end
end
