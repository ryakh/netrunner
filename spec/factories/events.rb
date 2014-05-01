# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    started "2014-05-01 12:21:43"
    finished "2014-05-01 12:21:43"
    is_closed false
    is_rated false
  end
end
