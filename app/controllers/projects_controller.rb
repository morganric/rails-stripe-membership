class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
   before_action :allow_iframe
   before_filter :authenticate_user!,  except: [:index, :show, :tag, :embed, :modal]
   
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.order('created_at DESC')
    @popular = @projects.order('views DESC')
    @random = @projects.shuffle
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
      
      @project.views = @project.views.to_i + 1
      @project.save

       render layout: 'blank'

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
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def allow_iframe
      response.headers['X-Frame-Options'] = "ALLOWALL"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title,:tag_list, :views, :description, :cover, :images, :image, :video, :user_id, :slug, :category_id)
    end
end
