class SitesController < ApplicationController
  before_action :set_profile, only: [:project, :profile, :tag, :category]
    before_action :allow_iframe
    before_action :admin_only, :except => [:project, :profile, :tag, :category]

  # GET /profiles
  # GET /profiles.json


  def project
      @project = Project.find(params[:id])
       render layout: 'blank'
  end

  def profile
        
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
    @category = Category.friendly.find(params[:category_id])
    @tags = []
    @projects = Project.where(:user_id => @profile.user.id, :category_id =>   @category.id)
    @categories = Category.where(:user_id => @profile.user.id)
       @projects.each do |p|
        p.tag_list.each do |tag|
          @tags << tag
        end
      end

      render layout: 'blank'
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
      

         @profile = Profile.friendly.find(request.subdomain)

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :second_name, :image, :bio, :domain, :twitter, :cover, :user_id, :slug)
    end
end