# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(first_name: 'Ivan',
                   last_name: 'Belitskii',
                   email: 'belitskii@gmail.com',
                   password: 'asdasd',
                   password_confirmation: 'asdasd',
                   confirmed_at: DateTime.now)

categories = Category.create([{ title: 'php' }, { title: 'ruby' }])

tests = []
tests << Test.create(title: 'php for beginners', level: 1, category: categories.first, author: user)
tests << Test.create(title: 'active record for monsters', level: 3, category: categories.last, author: user)
tests << Test.create(title: 'ruby for php developers', level: 2, category: categories.last, author: user)

questions = []
questions << Question.create(body: 'What does PHP stand for?', number: 1, test: tests.first)
questions << Question.create(body: 'PHP server scripts are surrounded by delimiters, which?',
                             number: 2,
                             test: tests.first)

questions << Question.create(body: 'What is a hash in ruby?', number: 1, test: tests.last)
questions << Question.create(body: 'What is a block in ruby?', number: 2, test: tests.last)

Answer.create(body: 'Hypertext processor', correct: 1, question: questions.first)
Answer.create(body: 'Personal Hypertext processor', question: questions.first)
Answer.create(body: 'HTML', question: questions.first)

Answer.create(body: '<?php...?>', correct: 1, question: questions.second)
Answer.create(body: '<...>', question: questions.second)
Answer.create(body: '<&></&>', question: questions.second)

Answer.create(body: 'Collection of unique keys and their values', correct: 1, question: questions.third)
Answer.create(body: 'Array', question: questions.third)
Answer.create(body: 'Ruby do not support hashes', question: questions.third)

Answer.create(body: 'A block consists of chunks of code', correct: 1, question: questions.fourth)
Answer.create(body: 'Function', question: questions.fourth)
Answer.create(body: 'Ruby do not support blocks', question: questions.fourth)
