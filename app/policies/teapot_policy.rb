class TeapotPolicy < ApplicationPolicy
  #The following was here by default, but wasn't immediately needed, so I have just commented it out for now.
  #class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  #end
  def new?
    user.admin?
  end

  def create?
    new?
  end

  def edit?
    update?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
