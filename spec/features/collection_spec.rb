require 'rails_helper'

RSpec.describe "Notes workflow" do

  let(:collection_name) { "ruby" }

  before :each do
    @test_user = create(:user)
  end

  it "allows a user to create aan view collection" do
    login
    visit 'collections/new'
    fill_in 'Name', with: 'ruby'
    click_button 'Add collection'
    expect(page).to have_content(collection_name)
  end

  def login
    visit '/'
    fill_in 'Email', with: @test_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end
