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
      visit "notes/new"
      expect(page).to have_content("You must be logged in to access this page")
    end

    it "collection dropdown has 'default' collection" do
      visit "notes/new"
      expect(page).to have_content("default")
    end

    it 'allows allows a user to create and tag note' do
      add_note(title: note_title)
      expect(page).to have_content("Tags: python, ruby")
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
