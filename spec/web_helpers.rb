def add_note(title, body)
  visit "notes/new"
  fill_in "Title", with: title
  fill_in "Body", with: body
  select "default", from: "note[collection]"
  click_button "Add note"
end

def login(user)
  visit '/'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

