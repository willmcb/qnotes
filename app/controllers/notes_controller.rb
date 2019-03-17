class NotesController < ApplicationController
  before_action :authorize

  def index
    params[:tag] ? @notes = current_user.notes.tagged_with(params[:tag], current_user) : @notes = current_user.notes
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.new(title: note_params[:title],
                                   body: note_params[:body],
                                   collection_id: note_params[:collection],
                                   tag_ids: note_params[:tag_ids])
    if @note.valid? && @note.save!
      flash[:notice] = "Note has been saved"
      redirect_to @note
    else
      flash[:notice] = @note.errors.full_messages.join(", ")
      redirect_to new_note_path
    end
  end

  def show
    @note = note_by_id(params[:id])
  end

  def edit
    @note = note_by_id(params[:id])
  end

  def update
    @updated = note_by_id(params[:id]).update!(title: note_params[:title],
                                               body: note_params[:body],
                                               collection_id: note_params[:collection],
                                               tag_ids: note_params[:tag_ids])
    if @updated
      flash[:notice] = "Note has been updated"
      redirect_to note_by_id(params[:id])
    else
      flash[:notice] = "There was an error when updating the note"
      redirect_to edit_note_path(params[:id])
    end

  end

  def destroy
    @note = note_by_id(params[:id])
    @destroyed = @note.destroy
    if @destroyed
      flash[:notice] = "Note has been deleted"
      redirect_to notes_path
    else
      flash[:notice] = "There was an error when deleting the note"
      redirect_to edit_note_path(params[:id])
    end
  end

  private

  def note_by_id(id)
    begin
      current_user.notes.find(id)
    rescue
      flash[:notice] = "ERROR: Note cannot be found"
      redirect_to notes_path
    end
  end

  def tags(ids)
    ids.reject(&:empty?).map { |id| Tag.find(id) }
  end

  def note_params
    params.require(:note).permit(:title, :body, :collection, tag_ids: [])
  end
end

