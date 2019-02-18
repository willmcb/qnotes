require 'rails_helper'

RSpec.describe "Notes workflow" do

  let(:note_title) { "this is a note title" }
  let(:note_body) { "this is the note body" }

  before :each do
    @test_user = create(:user)
  end

  describe "create" do
    it "allows a user to create a note" do
      login
      add_note
      expect(page).to have_content(note_title)
      expect(page).to have_content(note_body)
    end

    it "makes a user log in to create a new note" do
      visit "notes/new"
      expect(page).to have_content("You must be logged in to access this page")
    end

    it "collection dropdown has 'default' collection" do
      login
      visit "notes/new"
      expect(page).to have_content("default")
    end
  end

  describe "index" do
    xit "can return all notes" do
    end
  end

  describe "interaction with collections and tags" do
    xit "can return notes associated with a tag and a collection" do

    end
  end
  def add_note
    visit "notes/new"
    fill_in "Title", with: note_title
    fill_in "Body", with: note_body
    select "default", from: "note[collection]"
    click_button "Add note"
  end

  def login
    visit '/'
    fill_in 'Email', with: @test_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

end
