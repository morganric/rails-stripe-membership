class ProfilePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @profile = model
  end

  def index?
    @current_user.admin?
  end

  def show?
    true
  end

  def tag?
    true
  end

  def category?
    true
  end


   def edit?
    @current_user.admin? or @current_user == @profile.user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @profile.user
    @current_user.admin?
  end

end
