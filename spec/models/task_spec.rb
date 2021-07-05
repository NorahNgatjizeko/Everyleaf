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
       task = Task.new(task_name: 'Task', description: '')
       expect(task).not_to be_valid
     end
   end
   context 'If the task name and details are described' do
     it 'The task can be validated' do
       task = Task.new(
         task_name: 'task_name1',
         description: 'Hello',
         deadline: '2021/07/05',
         status: 'Completed',
         priority: 'high' )
       expect(task).to be_valid
     end
   end
 end

 #Step3
 describe 'Search Function' do
   let!(:task) { FactoryBot.create(:task) }
   let!(:second_task) { FactoryBot.create(:second_task) }
   context 'Title is performed by scope method' do
     it "Tasks containing search keywords are narrowed down" do
       expect(Task.task_name_search('task_name1')).to include(task)
       expect(Task.task_name_search('task_name1')).not_to include(second_task)
       expect(Task.task_name_search('task_name1').count).to eq 1
     end
   end

   context 'When the status is searched with the scope method' do
     it "Tasks that exactly match the status are narrowed down" do
       expect(Task.status_search('Completed')).to include(task)
       expect(Task.status_search('Completed')).not_to include(second_task)
       expect(Task.status_search('Completed').count).to eq 1
     end
   end

   context 'When performing fuzzy search and status search Title' do
         it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
           expect(Task.task_name_search('task_name1').status_search('Completed')).to include(task)
           expect(Task.task_name_search('task_name1').status_search('Completed')).not_to include(second_task)
           expect(Task.task_name_search('task_name1').status_search('Completed').count).to eq 1
         end
       end
     end
   end
