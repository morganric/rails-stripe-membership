  class ProjectPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @project = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def categories?
    true
  end

  def edit?
    @current_user.admin? or @current_user == @piece.user
  end

  def update?
    true
    # @current_user.admin? or @current_user == @piece.user
  end

  def destroy?
    return false if @current_user == @piece.user
    @current_user.admin?
  end

end
