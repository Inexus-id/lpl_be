FactoryGirl.define do
  factory :post do 
    title 'Test'
    content 'content testing'
    intro 'intro testing'
  end
  factory :event do
    description "event description"
    event_time Time.now
  end
  factory :day do 
    day_date Date.today
  end
  factory :admin do
    email "example@test.com"
    password "tupelo"
    approved true
  end
end
