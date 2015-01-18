feature "User signs in" do

  before(:each) do
    User.create(:email => "test@test.com",
    						:username => 'test',
                :password => '1234',
                :password_confirmation => '1234')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test', '1234')
    expect(page).to have_content("Welcome, test")
  end

  def sign_in(username, password)
    visit '/sessions/new'
    fill_in 'username', :with => username
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

 end