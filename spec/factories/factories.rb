FactoryBot.define do
  factory :venue do
    sequence(:name) { |n| "Venue #{n}" }
    address { Faker::Address.street_address }
    city { "Denver" }
    state { "CO" }
    zip { 80203 }
    capacity { (50..10000).to_a.sample }
  end

  factory :event do
    name { Faker::Music.band }
    tour { Tour.first }
    venue { Venue.order('RANDOM()').first }
    start_time { Faker::Time.forward(days: 23,  period: :evening) }
    end_time { 3.hours.since(start_time) }
  end
end
