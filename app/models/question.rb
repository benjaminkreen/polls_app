class Question < ActiveRecord::Base

  validate :text, :presence => true

  belongs_to(
    :poll,
    :primary_key => :id,
    :foreign_key => :question_id,
    :class_name => "Poll"
  )

  has_many(
    :answer_choices,
    :primary_key => :id,
    :foreign_key => :question_id,
    :class_name => "AnswerChoice"
  )

end