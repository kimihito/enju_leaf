class UseRestrictionPolicy < ApplicationPolicy
  def index?
    true if user.try(:has_role?, 'Librarian')
  end

  def show?
    true if user.try(:has_role?, 'Librarian')
  end

  def create?
    false
  end

  def update?
    if user.try(:has_role?, 'Administrator')
      true
    end
  end

  def destroy?
    false
  end
end
