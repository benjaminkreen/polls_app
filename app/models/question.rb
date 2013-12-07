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

  def results
    tally = {}

    choices_with_counts = self.answer_choices
              .select("answer_choices.choice choices, COUNT(responses.user_id) votes")
              .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
              .group("answer_choices.id")

    # choices_with_counts.map {|res|[res.choices, res.votes]}

    choices_with_counts.each do |res|
      tally[res.choices] = res.votes
    end
    tally
  end
end