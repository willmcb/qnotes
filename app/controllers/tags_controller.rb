class TagsController < ApplicationController

  def index
    @tags = current_user.tags
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.new(name: note_params[:name])
    if @tag.valid? && @tag.save!
      flash[:notice] = "New tag has been saved"
      redirect_to new_tag_path
    else
      flash[:notice] = @tag.errors.full_messages.join(", ")
      redirect_to new_tag_path
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
