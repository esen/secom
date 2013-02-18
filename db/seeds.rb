# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! :name => "Admin Adminovich", :role => "admin", :username => "admin", :email => "admin@mail.com", :password => "admin123", :password_confirmation => "admin123"

Ort::ExamType.create(
    [
        {:name => "General", :cost => 1000},
        {:name => "Physics", :cost => 500},
    ]
)

Ort::Participant.create(
    [
        {:name => "Abraham Lincoln"},
        {:name => "George Bush"},
        {:name => "Barak Obama"},
        {:name => "George Washington"},
        {:name => "Bill Clinton"},
        {:name => "Benjamin Harrison"},
        {:name => "Franklin D. Roosevelt"},
        {:name => "Harry S. Truman"},
        {:name => "Dwight D. Eisenhower"},
        {:name => "John F. Kennedy"},
        {:name => "Lyndon B. Johnson"},
        {:name => "Richard Nixon"},
        {:name => "Gerald Ford"},
        {:name => "Jimmy Carter"},
        {:name => "Ronald Reagan"},
        {:name => "George H. W. Bush"},
        {:name => "Woodrow Wilson"},
        {:name => "William McKinley"},
        {:name => "Rutherford B. Hayes"},
    ]
)