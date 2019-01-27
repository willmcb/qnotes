require 'rails_helper'

RSpec.describe Collection, type: :model do

  before :each do
    @user = create(:user)
  end

  describe 'creation' do
    it 'allows a user to create a collection' do
      collection = @user.collections.create(name: 'ruby')
      expect(collection).to be_valid
    end

    it 'enforces that a collection name must be unique' do
      collection = @user.collections.create(name: 'ruby')
      expect(collection).to be_valid
    end

    it 'stops a collection from being created if it doesn\'t have a name' do
      collection = @user.collections.create(name: nil)
      expect(collection).to_not be_valid
    end

    it 'doesn\'t allow a note to be created if it has no user' do
      collection = Collection.create(name: 'ruby')
      expect(collection).to_not be_valid
    end
  end

  describe 'interaction with notes' do
    it 'allows a note to be added to a collection' do
      erlang_col = @user.collections.create(name: "erlang")
      note = @user.notes.create(title: "something erlang", body: "this is a note about erlang", collection: erlang_col)
      expect(note.collection).to eq(erlang_col)

    end

    it 'allows a note to be removed from a collectioni, and added to another' do
      erlang_col = @user.collections.create(name: "erlang")
      haskel_col = @user.collections.create(name: "haskel")
      note = @user.notes.create(title: "something erlang", body: "this is a note about erlang", collection: erlang_col)
      note.update(collection: haskel_col)
      expect(note.collection).to eq(haskel_col)
    end
  end

  describe 'validation' do
    it 'will not allow a collection to be created if the name is longer than 100 charaters' do
      note = @user.collections.create(name: ('abc' * 35))
      expect(note).to_not be_valid
    end
  end
end
