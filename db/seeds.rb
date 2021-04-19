require 'factory_bot_rails'
require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Contact.destroy_all
SubEvent.destroy_all
Event.destroy_all
Venue.destroy_all
Tour.destroy_all
Organization.destroy_all
User.destroy_all

user = User.create!(first_name: "MVP", last_name: "Tour Manager", phone_number: "555-555-5555", email: "dev@example.com", role: 0)
org = Organization.create!(name: "MVP Organization", user: user)
tour = Tour.create!(name: "MVP Tour", start_date: "2021-08-23", end_date: "2021-12-31", organization: org)

FactoryBot.create_list(:venue, 10)
FactoryBot.create_list(:event_with_sub_events, 30)
FactoryBot.create_list(:contact, 10)

