# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

branch_main = Branch.create! :name => "Башкы Филиал", :address => "Бишкек"
branch_naryn = Branch.create! :name => "СЕКОМ - Нарын", :address => "Нарын"

User.create! :name => "Генеральный Директор", :role => "gd", :username => "gdirector", :email => "gdirector@secom.kg", :password => "gdirector123", :password_confirmation => "gdirector123", :branch_id => branch_main.id
User.create! :name => "Директор", :role => "dr", :username => "director", :email => "director@secom.kg", :password => "director123", :password_confirmation => "director123", :branch_id => branch_main.id
User.create! :name => "Завуч", :role => "vd", :username => "vdirector", :email => "vdirector@secom.kg", :password => "vdirector123", :password_confirmation => "vdirector123", :branch_id => branch_main.id
User.create! :name => "Мугалим", :role => "tr", :username => "teacher", :email => "teacher@secom.kg", :password => "teacher123", :password_confirmation => "teacher123", :branch_id => branch_main.id
User.create! :name => "Бухгалтер", :role => "ac", :username => "accountant", :email => "accountant@secom.kg", :password => "accountant123", :password_confirmation => "accountant123", :branch_id => branch_main.id
User.create! :name => "Секретарша", :role => "ad", :username => "admin", :email => "admin@secom.kg", :password => "admin123", :password_confirmation => "admin123", :branch_id => branch_main.id

User.create! :name => "Директор", :role => "dr", :username => "directorn", :email => "directorn@secom.kg", :password => "director123", :password_confirmation => "director123", :branch_id => branch_naryn.id
User.create! :name => "Завуч", :role => "vd", :username => "vdirectorn", :email => "vdirectorn@secom.kg", :password => "vdirector123", :password_confirmation => "vdirector123", :branch_id => branch_naryn.id
User.create! :name => "Мугалим", :role => "tr", :username => "teachern", :email => "teachern@secom.kg", :password => "teacher123", :password_confirmation => "teacher123", :branch_id => branch_naryn.id
User.create! :name => "Бухгалтер", :role => "ac", :username => "accountantn", :email => "accountantn@secom.kg", :password => "accountant123", :password_confirmation => "accountant123", :branch_id => branch_naryn.id
User.create! :name => "Секретарша", :role => "ad", :username => "adminn", :email => "adminn@secom.kg", :password => "admin123", :password_confirmation => "admin123", :branch_id => branch_naryn.id

Ort::ExamType.create(
    [
        {:name => "General", :cost => 1000, :branch_id => branch_main.id},
        {:name => "Physics", :cost => 500, :branch_id => branch_main.id},
    ]
)

Ort::Participant.create(
    [
        {:name => "Abraham Lincoln", :branch_id => branch_main.id},
        {:name => "George Bush", :branch_id => branch_main.id},
        {:name => "Barak Obama", :branch_id => branch_main.id},
        {:name => "George Washington", :branch_id => branch_main.id},
        {:name => "Bill Clinton", :branch_id => branch_main.id},
        {:name => "Benjamin Harrison", :branch_id => branch_main.id},
        {:name => "Franklin D. Roosevelt", :branch_id => branch_main.id},
        {:name => "Harry S. Truman", :branch_id => branch_main.id},
        {:name => "Dwight D. Eisenhower", :branch_id => branch_main.id},
        {:name => "John F. Kennedy", :branch_id => branch_main.id},
        {:name => "Lyndon B. Johnson", :branch_id => branch_main.id},
        {:name => "Richard Nixon", :branch_id => branch_naryn.id},
        {:name => "Gerald Ford", :branch_id => branch_naryn.id},
        {:name => "Jimmy Carter", :branch_id => branch_naryn.id},
        {:name => "Ronald Reagan", :branch_id => branch_naryn.id},
        {:name => "George H. W. Bush", :branch_id => branch_naryn.id},
        {:name => "Woodrow Wilson", :branch_id => branch_naryn.id},
        {:name => "William McKinley", :branch_id => branch_naryn.id},
        {:name => "Rutherford B. Hayes", :branch_id => branch_naryn.id},
    ]
)