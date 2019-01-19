require 'rails_helper'

RSpec.describe "Homepage is available" do
  it "allows user to see the home page at the root path" do
    visit "/"
    expect(page).to have_content("Qnotes")
  end
end
