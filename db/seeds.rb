# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

branch = Branch.create! :name => "Башкы Филиал", :address => "Бишкек"
branch = Branch.find_by_address("Нарын")

User.create! :name => "Генеральный Директор", :role => "gd", :username => "gdirectorn", :email => "gdirectorn@secom.kg", :password => "gdirector123", :password_confirmation => "gdirector123", :branch_id => branch.id
User.create! :name => "Директор", :role => "dr", :username => "directorn", :email => "directorn@secom.kg", :password => "director123", :password_confirmation => "director123", :branch_id => branch.id
User.create! :name => "Завуч", :role => "vd", :username => "vdirectorn", :email => "vdirectorn@secom.kg", :password => "vdirector123", :password_confirmation => "vdirector123", :branch_id => branch.id
User.create! :name => "Мугалим", :role => "tr", :username => "teachern", :email => "teachern@secom.kg", :password => "teacher123", :password_confirmation => "teacher123", :branch_id => branch.id
User.create! :name => "Бухгалтер", :role => "ac", :username => "accountantn", :email => "accountantn@secom.kg", :password => "accountant123", :password_confirmation => "accountant123", :branch_id => branch.id
User.create! :name => "Секретарша", :role => "ad", :username => "adminn", :email => "adminn@secom.kg", :password => "admin123", :password_confirmation => "admin123", :branch_id => branch.id

Ort::ExamType.create(
    [
        {:name => "General", :cost => 1000, :branch_id => branch.id},
        {:name => "Physics", :cost => 500, :branch_id => branch.id},
    ]
)

Ort::Participant.create(
    [
        {:name => "Abraham Lincoln", :branch_id => branch.id},
        {:name => "George Bush", :branch_id => branch.id},
        {:name => "Barak Obama", :branch_id => branch.id},
        {:name => "George Washington", :branch_id => branch.id},
        {:name => "Bill Clinton", :branch_id => branch.id},
        {:name => "Benjamin Harrison", :branch_id => branch.id},
        {:name => "Franklin D. Roosevelt", :branch_id => branch.id},
        {:name => "Harry S. Truman", :branch_id => branch.id},
        {:name => "Dwight D. Eisenhower", :branch_id => branch.id},
        {:name => "John F. Kennedy", :branch_id => branch.id},
        {:name => "Lyndon B. Johnson", :branch_id => branch.id},
        {:name => "Richard Nixon", :branch_id => branch.id},
        {:name => "Gerald Ford", :branch_id => branch.id},
        {:name => "Jimmy Carter", :branch_id => branch.id},
        {:name => "Ronald Reagan", :branch_id => branch.id},
        {:name => "George H. W. Bush", :branch_id => branch.id},
        {:name => "Woodrow Wilson", :branch_id => branch.id},
        {:name => "William McKinley", :branch_id => branch.id},
        {:name => "Rutherford B. Hayes", :branch_id => branch.id},
    ]
)