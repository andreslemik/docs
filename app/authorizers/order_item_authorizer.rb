class OrderItemAuthorizer < ApplicationAuthorizer
  def updatable_by?(user)
    resource.order.state == 'pending' && (user.has_any_role? :distributor, :logist)
  end

  def self.updatable_by?(user)
    user.has_any_role? :distributor, :logist
    # все дистрибьюторы и логисты могут добавлять или изменять order_items
  end

  def self.creatable_by?(user, options = {})
    if options[:for]
      (user.has_any_role? :distributor, :logist) && options[:for].state == 'pending'
    else
      user.has_any_role? :distributor, :logist
    end
  end

  def self.readable_by?(user)
    user.has_any_role? :distributor, :logist
    # все дистрибьюторы и логисты могут читать order_items
  end
end
