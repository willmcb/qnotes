require 'rails_helper'

RSpec.describe Note, type: :model do

  before :each do
    @user = create(:user)
  end
  describe 'creation' do
    it 'allows a user to create a note' do
      note = @user.notes.create(title: 'This is a note', body: 'This is a note body')
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
  end

  describe 'validation' do
    it 'will not allow a note to be created if the title is longer than 300 charaters' do
      note = @user.notes.create(title: ('abc' * 301), body: 'This is a note body')
      expect(note).to_not be_valid
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
