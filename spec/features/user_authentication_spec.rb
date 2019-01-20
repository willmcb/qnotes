require 'rails_helper'

RSpec.describe "User authentication" do
  let(:sign_up_error_message) { "Oops, couldn't create account. Please make" \
                                " sure you are using a valid email and password " \
                                "and try again."}
  before :each do
    create(:user)
  end

  describe "Sign up" do
   it "allows a user to sign up" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser'
     fill_in 'Email', with: 'testuser@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password'
     click_on 'Sign up'
     expect(page).to have_content 'Account created successfully'
   end

   it "shows an error if the email is already taken" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser'
     fill_in 'Email', with: 'testuser2@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password'
     click_on 'Sign up'
     expect(page).to have_content sign_up_error_message
   end

   it "shows an error if the password and password confirmation do not match" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser'
     fill_in 'Email', with: 'testuser@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password2'
     click_on 'Sign up'
     expect(page).to have_content sign_up_error_message
   end

   it "shows an error if the username is already taken" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser2'
     fill_in 'Email', with: 'testuser@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password2'
     click_on 'Sign up'
     expect(page).to have_content sign_up_error_message
   end
  end

  describe "Sign in" do
    xit "allows a user to sign in if they have the correct username and password" do

    end

    xit "stops a user signing in if there username is not registered" do

    end

    xit "stops a user signing in if there password is incorrect" do

    end

    xit "stops a user from signing in unless they enter a username and password" do

    end
  end


  describe "Sign out" do
    xit "allows the user to sign out if they click the sign out button once signed in" do

    end
  end
end
