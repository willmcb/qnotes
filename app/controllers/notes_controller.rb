class NotesController < ApplicationController
  before_action :authorize

  def index
    params[:tag] ? @notes = Note.tagged_with(params[:tag]) : @notes = Note.all
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
    @note = Note.find(params[:id])
    @markdown_body = markdown.render(@note.body)
  end

  private

  def tags(ids)
    ids.reject(&:empty?).map { |id| Tag.find(id) }
  end

  def note_params
    params.require(:note).permit(:title, :body, :collection, tag_ids: [])
  end

  def markdown
     config = Redcarpet::Render::HTML.new(prettyify: true, hard_wrap: true)
     Redcarpet::Markdown.new(config)
  end
end

