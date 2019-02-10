class NotesController < ApplicationController
  before_action :authorize

  def index
    params[:tag] ? @notes = Note.tagged_with(params[:tag]) : @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
    # TODO: refactor this
    @tags = tags(note_params[:tag_ids])
    @collection = Collection.find(note_params[:collection])
    @note = current_user.notes.new(title: note_params[:title],
                                   body: note_params[:body],
                                   collection: @collection,
                                   tags: @tags)
    if @note.valid? && @note.save!
      flash[:notice] = "Note has been saved"
      redirect_to @note
    else
      flash[:notice] = @note.errors.full_messages.join(", ")
      redirect_to new_note_path
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  private

  def tags(ids)
    ids.reject(&:empty?).map { |id| Tag.find(id) }
  end

  def note_params
    params.require(:note).permit(:title, :body, :collection, :tag_ids => [])
  end
end

