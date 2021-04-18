FactoryBot.define do
  factory :venue do
    name { Faker::Mountain.name + "Amphitheater" }
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
    start_time { Faker::Time.forward(days: 90,  period: :evening) }
    end_time { [1,2,3,4].sample.hours.since(start_time) }
  end

  FactoryBot.define do
    factory :contact do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      phone_number { "555-555-5555" }
      note { Faker::TvShows::MichaelScott.quote }
      sequence(:email) { |n| "contact_#{n}@example.com" }
      user { User.find(1) }
    end
  end
end
