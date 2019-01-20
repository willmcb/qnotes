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
      add_note
      expect(page).to have_content("Please login to post a note.")
    end
  end

  def add_note
    visit "notes/new"
    fill_in "Title", with: note_title
    fill_in "Body", with: note_body
    click_button "Add note"
  end

  def login
    visit '/'
    fill_in 'Email', with: @test_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

end
