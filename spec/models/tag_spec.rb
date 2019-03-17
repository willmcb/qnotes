require 'rails_helper'

RSpec.describe Tag, type: :model do
  before :each do
    @user = create(:user)
    @tag = @user.tags.create(name: 'ruby')
    @collection = @user.collections.create(name: 'test')
  end

  it "must have a name" do
    expect(@user.tags.new).to_not be_valid
    expect(@user.tags.new(name: "oop")).to be_valid
  end

  it "must have a unique name" do
    @user.tags.create(name: "oop")
    tag2 = @user.tags.create(name: "oop")
    expect(tag2).to_not be_valid
  end

  describe 'interactions with notes' do

    it 'can return the notes associated with a itself' do
      note = @user.notes.create(title: "This is a note",
                                body: "this is a note body",
                                tags: [@tag],
                                collection: @collection)
      note2 = @user.notes.create(title: "This is another note",
                                 body: "this is a note body",
                                 tags: [@tag],
                                 collection: @collection)
      expect(@tag.notes).to include(note, note2)
    end
  end
end
