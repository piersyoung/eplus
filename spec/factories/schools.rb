# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    name "MyString"
    is_private false
    gender_id 1
    dayboard_id 1
    religion_id 1
    address "MyText"
    town "MyString"
    county_id 1
    postcode "MyString"
    phone "MyString"
    fax "MyString"
    web "MyString"
    size 1
    agefrom 1
    ageto 1
    notes "MyText"
  end
end
