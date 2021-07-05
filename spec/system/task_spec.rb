require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'Should display created task' do
        visit new_task_path

        fill_in 'task', with: 'task_name1'
        fill_in 'task_description', with: 'description1'
        click_button 'Register'
        expect(page).to have_content 'Task was successfully created'
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
         expect(page).to have_content 'task_name1'
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
# Step3
    describe 'Search function' do
      before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  context 'If you do a fuzzy search by Title' do
     it "Filter by tasks that include search keywords" do
       visit tasks_path
       search_name = "task_name1"
       visit tasks_path(task_name: search_name)
       expect(page).to have_content search_name
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

    context 'Title performing fuzzy search of title and status search' do
      it "Narrow down tasks that include search keywords in the task name and exactly match the status" do
        search_name = "task_name2"
        search_status = "Not started"
          visit tasks_path(task_name: search_name, status: search_status)
          expect(page).to have_content 'task'
          expect(page).to have_content 'Not started'
      end
    end
  end
end
