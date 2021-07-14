# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([{email: 'john@gmail.com', password: 'pass123'},{email: 'jagath@gmail.com', password: 'pass123'}, email: 'sarath@gmail.com', password: 'pass123'])
user_meta = User.first.user_meta.create!(account_balance: 1000)
expense = User.first.expenses.create!(description: '1KG RICE', amount: 10)
transaction = LoanMoney.create!(:donor => User.first, recipient: User.last, amount: 100, description: 'Please pay back before 20/07/21')
