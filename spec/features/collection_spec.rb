require 'rails_helper'

RSpec.describe "Collections workflow" do

  let(:collection_name) { "ruby" }
  let(:another_collection_name) { "python-2.7" }
  let(:note_title) { "A note about coding" }
  let(:note_title_two) { "This is something else" }

  before :each do
    @test_user = create(:user)
    @test_user.collections.create(name: "Java")
    Tag.create(name: 'python')
    Tag.create(name: 'ruby')
  end

  it "allows a user to create and view collection" do
    login(@test_user)
    visit 'collections/new'
    fill_in 'Name', with: collection_name
    click_button 'Add collection'
    expect(page).to have_content(collection_name)
  end

  it 'allows a new collection to be selected when the user tries to add a new note' do
    login(@test_user)
    visit 'collections/new'
    fill_in 'Name', with: another_collection_name
    click_button 'Add collection'
    visit 'notes/new'
    expect(page).to have_content(another_collection_name)
  end

  it 'allows a user to add a collection to a note' do
    login(@test_user)
    visit 'notes/new'
    fill_in 'Title', with: note_title
    fill_in 'Body', with: "Note body about ruby note"
    select 'Java', :from => 'note_collection'
    select 'python', :from => 'Tag ids'
    select 'ruby', :from => 'Tag ids'
    click_button 'Add note'
    expect(page).to have_content("Collection: Java")

  end

  it 'allows allows a user to create and tag note' do
    login(@test_user)
    visit 'notes/new'
    fill_in 'Title', with: note_title
    fill_in 'Body', with: "Note body about ruby note"
    select 'Java', :from => 'note_collection'
    select 'python', :from => 'Tag ids'
    select 'ruby', :from => 'Tag ids'
    click_button 'Add note'
    expect(page).to have_content("Tags: python, ruby")
  end

  it 'allows a user to view all the notes asscociated with a collection' do
    login(@test_user)
    visit new_note_path
    fill_in 'Title', with: note_title
    fill_in 'Body', with: "Note body about ruby note"
    select 'Java', :from => 'note_collection'
    click_button 'Add note'

    visit new_note_path
    fill_in 'Title', with: note_title_two
    fill_in 'Body', with: "Note body about ruby note"
    select 'Java', :from => 'note_collection'
    click_button 'Add note'
    click_link 'Java'
    expect(page).to have_content(note_title, note_title_two)
  end
end
