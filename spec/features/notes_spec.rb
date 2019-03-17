require 'rails_helper'

RSpec.describe "Notes workflow" do

  let(:note_title) { "this is a note title" }
  let(:note_body) { "this is the note body" }
  let(:markdown_note_title) { "markdown test note" }
  let(:markdown_note_body) { "This is a code note\n\n```ruby\nputs 'hello word'\n``` " }

  before :each do
    feature_setup
  end

  describe "create" do
    it "allows a user to create a note" do
      add_note(title: note_title, body: note_body, col: 'default')
      expect(page).to have_content(note_title)
      expect(page).to have_content(note_body)
    end

    it "makes a user log in to create a new note" do
      log_out
      visit new_note_path
      expect(page).to have_content("You must be logged in to access this page")
    end

    it "collection dropdown has 'default' collection" do
      visit new_note_path
      expect(page).to have_content("default")
    end

    it 'allows allows a user to create and tag note' do
      add_note(title: note_title)
      expect(page).to have_content("python", "ruby")
    end
  end

  describe "index" do
    it "can return all notes" do
      add_note(title: note_title, body: note_body, col: 'default')
      add_note(title: markdown_note_title, body: note_body, col: 'default')
      visit notes_path
      expect(page).to have_content(note_title)
      expect(page).to have_content(markdown_note_title)
    end
  end

  describe 'edit' do
    it 'can edit a note' do
      edited_title = "This is an edited title"
      add_note(title: note_title)
      click_link 'Edit note'
      fill_in 'note_title', with: edited_title
      fill_in 'note_body', with: markdown_note_body
      click_button 'Update note'
      expect(page).to have_content(edited_title)
      expect(page).to have_content("Note has been updated")
    end
  end

  describe 'delete' do
    it 'can delete  a note' do
      add_note(title: note_title)
      click_link 'Delete note'
      expect(page).to have_content("Note has been deleted")
    end
  end

  describe "interaction with collections and tags" do
    xit "can return notes associated within a tag and a collection" do

    end
  end

  describe "Markdown" do
    it "A note can be rendered in markdown" do
      login(@test_user)
      add_note(title: markdown_note_title, body: markdown_note_body)
      expect(page).to_not have_content('```ruby')
      expect(page).to have_content("puts 'hello word'")
      expect(page).to have_selector('div', class: 'CodeRay')
      expect(page).to have_selector('div', class: 'code')
    end
  end

end
