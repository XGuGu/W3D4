# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all


starwar = User.create(username: 'starwar')
lordofrings = User.create(username: 'lordofrings')
tom = User.create(username: 'tom')
master_hand = User.create(username: 'master_hand')

food = Poll.create(author_id: master_hand.id, title: 'Food')
sleep_habits = Poll.create(author_id: master_hand.id, title: 'Sleep Habits')

favorite_food = Question.create(poll_id: food.id, text: 'What is your favorite food?')
steak = Question.create(poll_id: food.id, text: 'Do you like steak?')
sleep_time = Question.create(poll_id: sleep_habits.id, text: 'When do you sleep?')
sleep_hours = Question.create(poll_id: sleep_habits.id, text: 'How many hours do you sleep?')

favorite_food_sushi = AnswerChoice.create(question_id: favorite_food.id, text: 'Sushi')
favorite_food_burgers = AnswerChoice.create(question_id: favorite_food.id, text: 'Burgers')
favorite_food_pizza = AnswerChoice.create(question_id: favorite_food.id, text: 'Pizza')
steak_yes = AnswerChoice.create(question_id: steak.id, text: 'Yes!')

sleep_time_pre_12 = AnswerChoice.create(question_id: sleep_time.id, text: 'Before midnight')
sleep_time_post_12 = AnswerChoice.create(question_id: sleep_time.id, text: 'After midnight')
sleep_hours_6 = AnswerChoice.create(question_id: sleep_hours.id, text: 'Fewer than 6')
sleep_hours_6_to_8 = AnswerChoice.create(question_id: sleep_hours.id, text: 'Between 6 and 8')
sleep_hours_8 = AnswerChoice.create(question_id: sleep_hours.id, text: 'More than 8')

starwar_sleep_time = Response.create(user_id: starwar.id, answer_id: sleep_time_post_12.id)
starwar_sleep_hours = Response.create(user_id: starwar.id, answer_id: sleep_hours_6.id)
lordofrings_sleep_time = Response.create(user_id: lordofrings.id, answer_id: sleep_time_pre_12.id)
lordofrings_sleep_hours = Response.create(user_id: lordofrings.id, answer_id: sleep_hours_8.id)
tom_food = Response.create(user_id: tom.id, answer_id: favorite_food_pizza.id)
tom_steak = Response.create(user_id: tom.id, answer_id: steak_yes.id)
lordofrings_food = Response.create(user_id: lordofrings.id, answer_id: favorite_food_sushi.id)
lordofrings_steak = Response.create(user_id: lordofrings.id, answer_id: steak_yes.id)
