FactoryBot.define do
  factory :task do
    task_name {'task_name1'}
    description {'description1'}
    status {'Completed'}
    deadline {DateTime.now}

  end

  factory :second_task, class: Task do
    task_name {'task_name2'}
    description {'description2'}
    status {'Not started'}
    deadline {DateTime.tomorrow}
    association :user
  end
  end
