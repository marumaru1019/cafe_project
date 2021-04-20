# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# testのときにseedデータを読み込む
# load(Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb"))

AdminUser.create!(email: 'admin_ookado@unti.com', password: '285wylyp1n3yvv40bnlf', password_confirmation: '285wylyp1n3yvv40bnlf') if Rails.env.development?
AdminUser.create!(email: 'admin_ookado@unti.com', password: '285wylyp1n3yvv40bnlf', password_confirmation: '285wylyp1n3yvv40bnlf') if Rails.env.production?
AdminUser.create!(email: 'admin_ookado@unti.com', password: '285wylyp1n3yvv40bnlf', password_confirmation: '285wylyp1n3yvv40bnlf') if Rails.env.test?


# TimeTable.create!(time: '18:00~20:00') if Rails.env.test?
TimeTable.create!(time: '11:00~13:00') if Rails.env.production?
TimeTable.create!(time: '11:00~13:00') if Rails.env.production?
TimeTable.create!(time: '12:00~14:00') if Rails.env.production?
TimeTable.create!(time: '13:00~15:00') if Rails.env.production?
TimeTable.create!(time: '17:00~19:00') if Rails.env.production?
TimeTable.create!(time: '17:30~19:30') if Rails.env.production?
TimeTable.create!(time: '18:00~20:00') if Rails.env.production?
TimeTable.create!(time: '18:30~20:30') if Rails.env.production?
TimeTable.create!(time: '19:00~21:00') if Rails.env.production?

TimeTable.create!(time: '18:00~20:00') if Rails.env.test?



