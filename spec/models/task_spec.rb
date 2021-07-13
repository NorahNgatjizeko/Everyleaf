require 'rails_helper'
RSpec.describe Task, type: :model do
describe 'Validation test' do
  context 'If the task name is empty' do
    it 'The task cannot be validated' do
      task = Task.new(task_name: '', description: 'Failure test')
      expect(task).not_to be_valid
    end
  end
  context 'If the task details are empty' do
    it 'The task cannot be validated' do
      task = Task.new(task_name: 'task_name1', description: '')
      expect(task).not_to be_valid
    end
  end
  context 'If the task name and details are described' do
    it 'The task can be validated' do
       @user = FactoryBot.create(:user)
       task = FactoryBot.create(:task, user: @user)
       expect(task).to be_valid
     end
   end
 end
#Step3
describe 'Search Function' do
  let!(:task) { FactoryBot.create(:second_task) }
  context 'Title is performed by scope method' do
    it "Tasks containing search keywords are narrowed down" do
      expect(Task.task_name_search('task_name2')).to include(task)
      expect(Task.task_name_search('task_name2').count).to eq 1
    end
  end
  context 'When the status is searched with the scope method' do
    it "Tasks that exactly match the status are narrowed down" do
      expect(Task.status_search('Not started')).to include(task)
      expect(Task.status_search('Not started').count).to eq 1
    end
  end
  context 'When performing fuzzy search and status search Title' do
        it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
          expect(Task.task_name_search('task_name2').status_search('Not started')).to include(task)
          expect(Task.task_name_search('task_name2').status_search('Not started').count).to eq 1
        end
      end
    end
  end
