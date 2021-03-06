require 'rails_helper'

RSpec.describe Note, type: :model do

  before :each do
    @user = create(:user)
    @collection = @user.collections.create(name: 'test')
    @tag = @user.tags.create(name: 'ruby')
    @tag2 = @user.tags.create(name: 'elixir')
    @note = @user.notes.create(title: "This is a note",
                               body: "this is a note body",
                               tags: [@tag, @tag2])
  end

  describe 'creation' do
    it 'allows a user to create a note' do
      note = @user.notes.create(title: 'This is a note', body: 'This is a note body',
                                collection_id: @collection.id)
      expect(note).to be_valid
    end

    it 'stops a note from being created if it doesn\'t have a title' do
      note = @user.notes.create(body: 'This is a note body')
      expect(note).to_not be_valid
    end

    it 'do doesn\'t allow a note to be created if it has no body' do
      note = @user.notes.create(title: 'This is a note')
      expect(note).to_not be_valid
    end

    it 'do doesn\'t allow a note to be created if it has no user' do
      note = Note.create(title: 'This is a note', body: 'This is a note body')
      expect(note).to_not be_valid
    end

    it 'creates a default collection when a new user is created' do
      collection = @user.collections.find_by(name: 'default')
      expect(collection).to be_valid
    end
  end

  describe 'tags' do
    it 'can have multiple tags associated with it' do
      expect(@note.tags).to include(@tag, @tag2)
    end
  end

  describe 'validation' do
    it 'will not allow a note to be created if the title is longer than 300 charaters' do
      note = @user.notes.create(title: ('abc' * 301), body: 'This is a note body')
      expect(note).to_not be_valid
    end

    it 'notes must have a unique title' do
      note = @user.notes.create(title: "This is a note",
                         body: "body of the note",
                         tags: [@tag, @tag2])
      expect(note).to_not be_valid
    end
  end

  describe 'data transformation' do
    it 'adds a newline before and before end of code block' do
      body = "something\r\n```javascript\r\nconsole.log(\"hello\")\r\n```"
      newlines_added = "something\r\n\n```javascript\r\nconsole.log(\"hello\")\r\n\n```"
      note = @user.notes.create(title: 'newline test note', body: body, collection_id: @collection.id )
      expect(note.body).to match(newlines_added)
    end

  end
end
