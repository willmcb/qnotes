require 'rails_helper'

RSpec.describe "Notes workflow" do

  let(:collection_name) { "ruby" }
  let(:another_collection_name) { "python-2.7" }

  before :each do
    @test_user = create(:user)
  end

  it "allows a user to create aan view collection" do
    login
    visit 'collections/new'
    fill_in 'Name', with: collection_name
    click_button 'Add collection'
    expect(page).to have_content(collection_name)
  end

  it 'allows a new collection to be selected when the user tries to add a new note' do
    login
    visit 'collections/new'
    fill_in 'Name', with: another_collection_name
    click_button 'Add collection'
    visit 'notes/new'
    expect(page).to have_content(another_collection_name)
  end

  def login
    visit '/'
    fill_in 'Email', with: @test_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end
