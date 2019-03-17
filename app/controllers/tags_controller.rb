class TagsController < ApplicationController
  before_action :authorize

  def index
    @tags = current_user.tags
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.new(name: note_params[:name])
    if @tag.valid? && @tag.save
      flash[:notice] = "New tag has been saved"
      redirect_to new_tag_path
    else
      flash[:notice] = @tag.errors.messages[:name].first
      redirect_to new_tag_path
    end
  end

  def destroy
    @tag = current_user.tags.find(params[:id])
    @destroyed = @tag.destroy
    if @destroyed
      flash[:notice] = "The tag '#{@tag.name}' has been deleted"
      redirect_to tags_path
    else
      flash[:notice] = "There was an error when deleting the tag: #{@tag.name}"
      redirect_to tag_path(params[:id])
    end
  end

  def show
    @tag = current_user.tags.find(params[:id])
    @notes = @tag.notes
  end

  private
  def note_params
    params.require(:tag).permit(:name)
  end
end
