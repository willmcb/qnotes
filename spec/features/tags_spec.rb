require 'rails_helper'

RSpec.describe "Tags workflow" do

  let(:collection_name) { "ruby" }
  let(:another_collection_name) { "python-2.7" }
  let(:note_title) { "A note about coding" }
  let(:note_title_two) { "This is something else" }

  before :each do
    feature_setup
  end

  it "allows a user to create a new tag" do
    visit new_tag_path
    fill_in 'name', with: 'cobol'
    click_button 'Add tag'
    expect(page).to have_content('New tag has been saved')
  end

  it 'can delete  a tag' do
    visit '/tags'
    click_link 'python'
    click_link 'Delete tag'
    expect(page).to have_content("The tag 'python' has been deleted")
  end
end
