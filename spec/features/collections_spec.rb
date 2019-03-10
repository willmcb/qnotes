require 'rails_helper'

RSpec.describe "Collections workflow" do

  let(:collection_name) { "ruby" }
  let(:another_collection_name) { "python-2.7" }
  let(:note_title) { "A note about coding" }
  let(:note_title_two) { "This is something else" }

  before :each do
    feature_setup
  end

  it "allows a user to create and view collection" do
    visit 'collections/new'
    fill_in 'name', with: collection_name
    click_button 'Add collection'
    expect(page).to have_content(collection_name)
  end

  it 'allows a new collection to be selected when the user tries to add a new note' do
    visit 'collections/new'
    fill_in 'name', with: another_collection_name
    click_button 'Add collection'
    visit 'notes/new'
    expect(page).to have_content(another_collection_name)
  end

  it 'allows a user to add a collection to a note' do
    visit new_note_path
    add_note(title: note_title)
    expect(page).to have_content("Java")
  end

  it 'allows a user to view all the notes asscociated with a collection' do
    add_note(title: note_title)
    add_note(title: note_title_two)
    expect(page).to have_content(note_title, note_title_two)
  end

  xit 'allows you to view all collections' do
  end
end
