class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :dashboard

    if user.admin?
      can :manage, :all
      return
    end

    case user.role
    when "sales"
      can :manage, [Customer, Order, OrderItem]
      can :read, [Product, StockMovement]
    when "finance"
      can :manage, FinancialEntry
      can :read, [Customer, Product, Order, OrderItem]
    else
      can :manage, [Product, StockMovement]
      can :read, [Customer, Order, OrderItem, FinancialEntry]
    end

    cannot :destroy, :all
    cannot :manage, User
  end
end
