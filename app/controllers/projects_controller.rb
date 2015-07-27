class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
   before_action :allow_iframe
   before_filter :authenticate_user!,  except: [:index, :show, :tag, :embed, :modal, :random, :popular]
   
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.order('created_at DESC').page(params[:page]).per(10)
    
  end

  def admin
    @projects = Project.where(:user_id => current_user.id).order('created_at DESC').page(params[:page]).per(5)
    @views = 0
    @projects.each do |p|
      @views = @views + p.views
    end
  end

  def random
    @projects = Project.all.order('created_at DESC')
    @random = @projects.shuffle
  end


  def popular
    @projects = Project.all.order('created_at DESC')
    @popular = Project.all.order('views DESC')
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
      
      @project.views = @project.views.to_i + 1
      @project.save

  end

  def tag
      
      @tag = params[:tag]
      @tags = []
      @projects = Project.tagged_with(@tag)

       @projects.each do |p|
        p.tag_list.each do |tag|
          unless tag == params[:tag]
          @tags << tag
          end
        end
      end

      @tags = @tags.uniq
      
      
      @other_tags = []

       @projects.each do |p|
        p.tag_list.each do |tag|
          unless tag == params[:tag]
            @other_tags << tag
          end
        end
      end

      @other_tags = @other_tags.uniq

  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.views = 1

    if project_params[:video] != nil
    file = project_params[:video].tempfile.open
    json = Cloudinary::Uploader.upload_large(file, 
            :resource_type => :video, :chunk_size => 6_000_000, :public_id => @project.title)

    @project.video = json['url']
   
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to admin_url(:user_id => current_user.id), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def allow_iframe
      response.headers['X-Frame-Options'] = "ALLOWALL"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title,:tag_list, :views, :description, :cover, :images, :image, :video, :user_id, :slug, :category_id, :embed)
    end
end
