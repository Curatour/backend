FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "3333333333" }
    email { Faker::Internet.email }
    role { 1 }

    factory :user_with_tour do
      after(:create) do |user|
        create(:organization_with_tour, user: user)
      end
    end
  end

  factory :organization do
    name { Faker::Mountain.name }
    user { User.first }

    factory :organization_with_tour do
      after(:create) do |org|
        create(:tour, organization: org)
      end
    end
  end

  factory :venue do
    name { Faker::Mountain.name + " Amphitheater" }
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
    start_time { Faker::Time.forward(days: 90,  period: :evening).beginning_of_hour }
    end_time { [1,2,3,4].sample.hours.since(start_time).beginning_of_hour }

    factory :event_with_sub_events do
      transient do
        sub_event_count { (3..5).to_a.sample}
      end

      after(:create) do |event, evaluator|
        create_list(:sub_event, evaluator.sub_event_count, event: event, start_time: 30.minutes.before(event.start_time), end_time: event.start_time)
        event.reload
      end
    end
  end

  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "555-555-5555" }
    note { Faker::TvShows::MichaelScott.quote }
    sequence(:email) { |n| "contact_#{n}@example.com" }
    user { User.first }
  end

  factory :sub_event do
    name { "Find the " + Faker::Music.instrument }
    description { Faker::Marketing.buzzwords }
    event { Event.order('RANDOM()').first }
    start_time { Faker::Time.forward(days: 90,  period: :evening).beginning_of_hour }
    end_time { [1,2,3,4].sample.hours.since(start_time).beginning_of_hour }
  end

  factory :tour do
    sequence(:name) { |n| "Tour #{n}" }
    start_date { Faker::Date.forward(days: 90) }
    end_date { [90, 120, 150].sample.days.since(start_date) }
    organization
  end
end
