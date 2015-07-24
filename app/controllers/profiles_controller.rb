class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :page, :edit, :update, :destroy, :tag, :category, :about, :cv]
    before_action :allow_iframe
    before_action :admin_only, :except => [:show, :page, :tag, :category, :update, :edit, :about, :cv]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
        
       @categories = Category.where(:user_id => @profile.user.id)
       @projects = Project.where(:user_id => @profile.user.id).order('created_at DESC')
       @tags = []
       @popular = Project.where(:user_id => @profile.user.id).order('views DESC')
       @random = @projects.shuffle

       @projects.each do |p|
        p.tag_list.each do |tag|
          @tags << tag
        end
      end
      @tags = @tags.uniq

  end

  def about

      @categories = Category.where(:user_id => @profile.user.id)
  end

  def cv
      @cv = Item.where(:user_id => @profile.user.id).order('start DESC')
      @categories = Category.where(:user_id => @profile.user.id)
  end

  def page
          @categories = Category.where(:user_id => @profile.user.id)
       @projects = Project.where(:user_id => @profile.user.id).order('created_at DESC')
       @tags = []

       @projects.each do |p|
        p.tag_list.each do |tag|
          @tags << tag
        end
      end
      @tags = @tags.uniq

       render layout: 'blank'
  end

  def tag
      @cv = Item.where(:user_id => @profile.user.id).order('start DESC')
      @tag = params[:tag]
       @categories = Category.where(:user_id => @profile.user.id)
      @projects = Project.where(:user_id => @profile.user.id)
      @tags = []

       @projects.each do |p|
        p.tag_list.each do |tag|
          @tags << tag
        end
      end

      @tags = @tags.uniq
      
      @projects = @projects.tagged_with(@tag)
      @other_tags = []

       @projects.each do |p|
        p.tag_list.each do |tag|
          unless tag == params[:tag]
            @other_tags << tag
          end
        end
      end

      @other_tags = @other_tags.uniq


       render layout: 'blank'
  end

  def category
    
    @tags = []
    @category = Category.friendly.find(params[:category_id])
    @projects = Project.where(:user_id => @profile.user.id, :category_id => @category.id)
    @categories = Category.where(:user_id => @profile.user.id)

       @projects.each do |p|
        p.tag_list.each do |tag|
          @tags << tag
        end
      end
      @tags = @tags.uniq


      render layout: 'blank'
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def admin_only
    unless @current_user.try(:admin?) 
      redirect_to :root, :alert => "Access denied."
    end
  end

    def allow_iframe
      response.headers['X-Frame-Options'] = "ALLOWALL"
    end

  
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      
    #for subdomains on heroku
      # @profile = Profile.find(params[:id])

    if params[:id] == nil
        if params[:user_id] != nil
          @profile = Profile.friendly.find(params[:user_id])
        else
         @profile = Profile.friendly.find(request.subdomain)
       end
      else
        @profile = Profile.friendly.find(params[:id])
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :second_name, :image, :bio, :domain, :twitter, :tumblr, :instagram, :cover, :user_id, :slug)
    end
end
