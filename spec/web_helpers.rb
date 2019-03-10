def feature_setup
  @test_user = create(:user)
  @test_user.collections.create(name: "Java")
  @test_user.tags.create(name: 'python')
  @test_user.tags.create(name: 'ruby')
  login(@test_user)
end

def login(user)
  visit '/'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

def log_out
  visit '/logout'
end

def add_note(title: 'title', col: 'Java',
             tag1: 'python', tag2: 'ruby',
             body: 'Note body about ruby note')
  visit new_note_path
  fill_in 'note_title', with: title
  fill_in 'note_body', with: body
  select col, :from => 'note_collection'
  select tag1, :from => 'note_tag_ids'
  select tag2, :from => 'note_tag_ids'
  click_button 'Add note'
end
