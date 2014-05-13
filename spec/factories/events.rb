FactoryGirl.define do
  factory :event do
    started_at  Time.current.beginning_of_week
    finished_at Time.current.end_of_week
  end
end
