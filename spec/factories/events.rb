FactoryGirl.define do
  factory :event do
    started_at  DateTime.now.beginning_of_week
    finished_at DateTime.now.end_of_week
  end
end
