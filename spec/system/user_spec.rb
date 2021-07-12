require 'rails_helper'
RSpec.describe 'User management function', type: :system do

  describe 'User creation function' do
    context 'When creating a new user' do
      it 'User is registered' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample1@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button "Register"
      end
    end
    context 'When the user tries to jump to the task list screen without logging' do
      it 'Transition to the login screen' do
        visit tasks_path
        expect(page).to have_content 'Log In'
      end
    end
  end
  describe 'Testing session functionality' do
    before do
      @user = FactoryBot.create(:user)
      admin_user = FactoryBot.create(:admin_user)
    end
    context 'When user tries login' do
      it 'Login is a success' do

          visit new_session_path
          fill_in 'email', with: @user.email
          fill_in 'password', with: @user.password
        click_button "Login"
        visit user_path (@user.id)
        expect(page).to have_content 'New task'
      end
    end
    context 'When the user tries to jump to your details screen' do
      it 'You can jump to your details screen' do
        visit new_session_path
        fill_in 'session[email]', with: 'sample1@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit user_path (@user.id)
        expect(page).to have_content 'Welcome to your page sample'
      end
    end
    context 'When a general user jumps to another person\'s details screen' do
      it 'It will transition to the task list screen' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit user_path (@user.id)
        expect(page).to have_content 'Tasks'
      end
    end
    context 'When the user tries to logout' do
      it 'Logout successfully' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button "Login"
        click_link "Logout"
        expect(page).to have_content 'Sign up'
      end
    end
  end
  describe 'Admin screen test function' do
    before do
      @user = FactoryBot.create(:user)
      admin_user = FactoryBot.create(:admin_user)
    end
    context 'When admin tries to access admin screen' do
      it 'Admin screen is successfully displayed' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
         fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit admin_users_path
        expect(page).to have_content 'Users List'
      end
    end
    context 'When general user tries to access admin screen' do
      it 'Admin screen is not displayed' do
        visit new_session_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        visit admin_users_path
        expect(page).to have_content 'Tasks'
      end
    end
    context 'When admin tries to register new user' do
      it 'Admin can register user successfully' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
         fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit new_admin_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample1@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button "Register"
        expect(page).to have_content 'Users list'
      end
    end
    context 'When admin tries to access the user details screen' do
      it 'The user details screen is successfully displayed' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
         fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit admin_user_path (@user.id)
        expect(page).to have_content 'Tasks of '+@user.name
      end
    end
    context 'When admin tries to edit the user' do
      it 'The user edit screen is successfully displayed' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
         fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit edit_admin_user_path(@user.id)
        expect(page).to have_content 'Edit the user'
      end
    end
    context 'When admin tries to delete a user' do
      it 'The user is deleted successfully' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button "Login"
        visit admin_users_path
        click_on "delete#{@user.id}"
        expect(page).to_not have_content @user.id
      end
    end
  end
end
