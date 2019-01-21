class NotesController < ApplicationController
  def new
    @note = Note.new
    @collections = Collections.all
  end

  def create
    if current_user
      note = current_user.notes.new(note_params)
      if note.save!
         puts "Note has been saved"
      else
        flash[:notice] = note.errors.full_messages.join(", ")
      end
      redirect_to show_note_path(id: note.id)
    else
      flash[:notice] =  "Please login to post a note."
      redirect_to new_user_path
    end
  end

  def show
    @note = Note.find(show_note_params)
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

  def show_note_params
    params.require(:id)
  end
end

