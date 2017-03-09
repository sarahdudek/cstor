class ResourcesController < ApplicationController
  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find(params[:id])
    @tags = @resource.tags
    @likes = @resource.likes
  end

  def new
    if !current_user.admin
      redirect_to resources_path
    end
  end

  def create
    @resource = current_user.resources.new(resource_params)
    tags = tag_params[:tag].split(',').map! {|tag| tag.lstrip}
    tags.each do |tag|
      if Tag.find_by(name: tag)
        @resource.tags << Tag.find_by(name: tag)
      else
        @resource.tags << Tag.create(name: tag)
      end
    end

    if @resource.save && current_user.admin
      redirect_to @resource, notice: "Your Resource was a success!"
    else
      render :new, status: 400
    end
  end



  private

  def resource_params
    params.require(:resource).permit(:title, :abstract, :url, :teacher_only)
  end

  def tag_params
    params.require(:resource).permit(:tag)
  end


end
