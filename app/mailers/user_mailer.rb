class UserMailer < ActionMailer::Base
  default from: "docs@#{ENV['DOCS_HOST']}"

  def new_order(user, order)
    @order = order
    @user = user
    mail(to: @user.email, subject: "Новый заказ №#{@order.id}")
  end

  def update_order(user, order)
    @order = order
    @user = user
    mail(to: @user.email, subject: "Заказ №#{@order.id} был изменён")
  end

  def document_added(user, order, document)
    @order = order
    @user = user
    @document = document
    mail(to: @user.email, subject: "К заказу №#{@order.id} добавлен документ")
  end

  def new_revise(user, revise)
    @user = user
    @revise = revise
    @distributor = revise.distributor
    mail(to: @user.email, subject: "Новый акт сверки c #{@distributor.name}")
  end

  def new_message(user, message)
    @user = user
    @message = message
    mail(to: @user.email, subject: 'Новое сообщение')
  end
end
