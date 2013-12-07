# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  u1 = User.new
  u1.user_name = "Ben Miller"
  u1.save!

  u2 = User.new
  u2.user_name = "Bono Vox"
  u2.save!

  u3 = User.new
  u3.user_name = "John Smith"
  u3.save!

  u4 = User.new
  u4.user_name = "Cindy Lou"
  u4.save!

  p1 = Poll.new
  p1.title = "Animal Survey!"
  p1.author_id = u1.id
  p1.save!

  q11 = Question.new
  q11.text = "How many cats do you have?"
  q11.poll_id = p1.id
  q11.save!

  ac111 = AnswerChoice.new
  ac111.choice = "Zero"
  ac111.question_id = q11.id
  ac111.save!

  ac112 = AnswerChoice.new
  ac112.choice = "One"
  ac112.question_id = q11.id
  ac112.save!

  ac113 = AnswerChoice.new
  ac113.choice = "More than one."
  ac113.question_id = q11.id
  ac113.save!

  q12 = Question.new
  q12.text = "How many dogs?"
  q12.poll_id = p1.id
  q12.save!

  ac121 = AnswerChoice.new
  ac121.choice = "Zero"
  ac121.question_id = q12.id
  ac121.save!

  ac122 = AnswerChoice.new
  ac122.choice = "One"
  ac122.question_id = q12.id
  ac122.save!

  ac123 = AnswerChoice.new
  ac123.choice = "More than one."
  ac123.question_id = q12.id
  ac123.save!

  r1 = Response.new
  r1.user_id = u2.id
  r1.answer_choice_id = ac112.id
  r1.save!

  r2 = Response.new
  r2.user_id = u3.id
  r2.answer_choice_id = ac113.id
  r2.save!

  r3 = Response.new
  r3.user_id = u4.id
  r3.answer_choice_id = ac113.id
  r3.save!
end



