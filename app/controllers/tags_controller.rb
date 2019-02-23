class TagsController < ApplicationController

  def index
    @tags = current_user.tags.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.new(title: note_params[:title])
    if @tag.valid? && @tag.save!
      flash[:notice] = "New tag has been saved"
      redirect_to new_tag_path
    else
      flash[:notice] = @tag.errors.full_messages.join(", ")
      redirect_to new_tag_path
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @notes = @tag.notes
  end

  private
  def note_params
    params.require(:tag).permit(:title)
  end
end
