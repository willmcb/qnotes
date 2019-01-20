require 'rails_helper'

RSpec.describe "User authentication" do
  let(:sign_up_error_message) { "Oops, couldn't create account. Please make" \
                                " sure you are using a valid email and password " \
                                "and try again."}
  let(:sign_up_success_message) { 'Account created successfully' }

  let(:login_error_message) { 'Incorrect email or password, try again.' }
  let(:login_success_message) { 'Successfully logged in!' }
  before :each do
    @test_user = create(:user)
  end

  describe "Sign up" do
   it "allows a user to sign up" do
     visit 'users/new'
     fill_in 'Username', with: 'dave'
     fill_in 'Email', with: 'dave@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password'
     click_on 'Sign up'
     expect(page).to have_content sign_up_success_message
   end

   it "shows an error if the email is already taken" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser7'
     fill_in 'Email', with: 'testuser@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password'
     click_on 'Sign up'
     expect(page).to have_content sign_up_error_message
   end

   it "shows an error if the password and password confirmation do not match" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser4'
     fill_in 'Email', with: 'testuser4@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password2'
     click_on 'Sign up'
     expect(page).to have_content sign_up_error_message
   end

   it "shows an error if the username is already taken" do
     visit 'users/new'
     fill_in 'Username', with: 'testuser'
     fill_in 'Email', with: 'testuser9@test.com'
     fill_in 'Password', with: 'password'
     fill_in 'Password confirmation', with: 'password'
     click_on 'Sign up'
     expect(page).to have_content sign_up_error_message
   end
  end

  describe "Sign in" do
    it "allows a user to sign in if they have the correct username and password" do
      visit 'login'
      fill_in 'Email', with: @test_user.email
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      expect(page).to have_content(login_success_message)
    end

    it "stops a user signing in if there username is not registered" do
      visit 'login'
      fill_in 'Email', with: 'notregistered@nothing.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      expect(page).to have_content(login_error_message)
    end

    it "stops a user signing in if there password is incorrect" do
      visit 'login'
      fill_in 'Email', with: @test_user.email
      fill_in 'Password', with: 'incorrect_password'
      click_on 'Log in'
      expect(page).to have_content(login_error_message)
    end

    it "stops a user from signing in unless they enter a username and password" do
      visit 'login'
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_on 'Log in'
      expect(page).to have_content(login_error_message)
    end
  end

  describe "Sign out" do
    it "allows the user to sign out if they click the sign out button once signed in" do
      visit 'login'
      fill_in 'Email', with: @test_user.email
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      click_on 'Log out'
      expect(page).to_not have_content(@test_user.email)
      expect(page).to have_content('Logged out!')

    end
  end
end
