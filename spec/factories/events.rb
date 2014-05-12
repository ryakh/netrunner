FactoryGirl.define do
  factory :event do
    started_at  Time.now.beginning_of_week
    finished_at Time.now.end_of_week
  end
end
