class NotesController < ApplicationController
  before_action :authorize

  def new
    @note = Note.new
  end

  def create
    note = current_user.notes.new(title: note_params[:title],
                                  body: note_params[:body],
                                  collection_id: note_params[:collection])
    if note.save!
        flash[:notice] = "Note has been saved"
    else
      flash[:notice] = note.errors.full_messages.join(", ")
    end
    redirect_to show_note_path(id: note.id)
  end

  def show
    @note = Note.find(show_note_params)
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, :collection)
  end

  def show_note_params
    params.require(:id)
  end
end

