# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    pupil_id 1
    school_id 1
    status_id 1
    notes "MyText"
  end
end
