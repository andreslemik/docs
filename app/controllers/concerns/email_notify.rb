module EmailNotify
  extend ActiveSupport::Concern
  def notice(email_type, *args)
    case email_type
    when 'new_revise'
      revise = args[0][:revise]
      users = User.with_role(:logist_prime) << revise.distributor.user
    when 'new_message'
      message = args[0][:message]
      users = []
      message.recipients.each do |r|
        users << r.user
      end
    else
      order = args[0][:order]
      users = User.with_role(:logist_prime) << order.distributor.user
    end

    users.each do |user|
      domain = (/(.+)@(.+)/).match(user.email)[2]
      case email_type
      when 'new_order'
        UserMailer.new_order(user, order).deliver unless domain == 'example.com' # don't send to example.com
      when 'update_order'
        UserMailer.update_order(user, order).deliver unless domain == 'example.com'
      when 'document_added'
        document = args[0][:document]
        UserMailer.document_added(user, order, document).deliver unless domain == 'example.com'
      when 'new_revise'
        revise = args[0][:revise]
        UserMailer.new_revise(user, revise).deliver unless domain == 'examples.com'
      when 'new_message'
        message = args[0][:message]
        UserMailer.new_message(user, message).deliver unless domain == 'exmaple.com'
      end
    end
  end
end
