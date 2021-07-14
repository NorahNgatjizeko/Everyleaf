require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:user, name: 'aaaa',
                             email: 'aaaa@gmail.com',
                             password: 'password',
                             password_confirmation: 'password')
    visit new_session_path
    fill_in 'email', with: 'aaaa@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    @user = User.first
    FactoryBot.create(:task, task_name: "task_name1", description: "content1", deadline: "2021/1/1", status:"Completed", priority: "low", user_id: @user.id)
    FactoryBot.create(:task, task_name: "task_name2", description: "content2", deadline: "2021/1/1", status:"Completed", priority: "low", user_id: @user.id)
    FactoryBot.create(:task, task_name: "task_name3", description: "content3", deadline: "2021/1/1", status:"Completed", priority: "low", user_id: @user.id)
  end
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'Should display created task' do
        visit new_task_path
        fill_in "task", with: 'task_name1'
        fill_in 'task_description', with: 'description1'
        click_button 'Register'
        expect(page).to have_content 'The task was successfully created'
      end
    end
  end
  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
      end
    end
  end
 describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the relevant task is displayed' do
         task = Task.create(task_name: 'task_name1', description: 'description1')
        visit tasks_path(task)
        expect(page).to have_content 'Task name'
      end
    end

    context 'When the tasks are arranged in descending order of creation date and time' do
          it 'A new task is displayed at the top' do
            task = Task.create(task_name: 'task_name1', description: 'description1')
            visit tasks_path
            assert Task.all.order(created_at: "desc")
      end
    end
  end

  context 'If you do a fuzzy search by name' do
     it "Filter by tasks that include search keywords" do
       visit tasks_path
       search_task_name = "task_name1"
       visit tasks_path(task_name: search_task_name)
       expect(page).to have_content 'Task name'
     end
   end
   context 'When you search for status' do
     it "Tasks that exactly match the status are narrowed down" do
       visit tasks_path
       search_status = "Not started"
       visit tasks_path(status: search_status)
       expect(page).to have_content search_status
     end
   end

    context 'When you search by title and status' do
      it "Tasks that include the search keyword in the title and exactly match the status are narrowed down" do
        search_task_name = "task_name2"
        search_status = "Not started"
          visit tasks_path(task_name: search_task_name, status: search_status)
          expect(page).to have_content 'Task name'
          expect(page).to have_content 'Status'
      end
    end
end
