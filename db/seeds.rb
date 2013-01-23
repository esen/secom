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
        {:name => "Barak Obama", :password => "obama"},
        {:name => "George Washington", :password => "washington"},
        {:name => "Bill Clinton", :password => "clinton"},
        {:name => "Benjamin Harrison", :password => "harrison"},
        {:name => "Franklin D. Roosevelt", :password => "roosevelt"},
        {:name => "Harry S. Truman", :password => "truman"},
        {:name => "Dwight D. Eisenhower", :password => "eisenhower"},
        {:name => "John F. Kennedy", :password => "kennedy"},
        {:name => "Lyndon B. Johnson", :password => "johnson"},
        {:name => "Richard Nixon", :password => "nixon"},
        {:name => "Gerald Ford", :password => "ford"},
        {:name => "Jimmy Carter", :password => "carter"},
        {:name => "Ronald Reagan", :password => "reagan"},
        {:name => "George H. W. Bush", :password => "bush"},
        {:name => "Woodrow Wilson", :password => "wilson"},
        {:name => "William McKinley", :password => "mckinley"},
        {:name => "Rutherford B. Hayes", :password => "hayes"},
    ]
)