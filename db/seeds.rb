# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Ort::ExamType.create(
    [
        {:name => "General", :cost => 1000},
        {:name => "Physics", :cost => 500},
    ]
)

Ort::Participant.create(
    [
        {:name => "Abraham Lincoln", :password => "lincoln"},
        {:name => "George Bush", :password => "bush"},
    ]
)