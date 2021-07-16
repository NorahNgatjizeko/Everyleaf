FactoryBot.define do
  factory :label do
    name { "Label 1" }
  end

  factory :label2, class: Label do
  	name { "Label 2" }
  end
end
