# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! :name => "Генеральный Директор", :role => "gd", :username => "gdirector", :email => "gdirector@secom.kg", :password => "gdirector123", :password_confirmation => "gdirector123"
User.create! :name => "Директор", :role => "dr", :username => "director", :email => "director@secom.kg", :password => "director123", :password_confirmation => "director123"
User.create! :name => "Завуч", :role => "vd", :username => "vdirector", :email => "vdirector@secom.kg", :password => "vdirector123", :password_confirmation => "vdirector123"
User.create! :name => "Мугалим", :role => "tr", :username => "teacher", :email => "teacher@secom.kg", :password => "teacher123", :password_confirmation => "teacher123"
User.create! :name => "Бухгалтер", :role => "ac", :username => "accountant", :email => "accountant@secom.kg", :password => "accountant123", :password_confirmation => "accountant123"
User.create! :name => "Секретарша", :role => "ad", :username => "admin", :email => "admin@secom.kg", :password => "admin123", :password_confirmation => "admin123"

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