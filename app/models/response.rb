class Response < ActiveRecord::Base

  attr_accessible :user_id, :answer_choice_id

  validate :respondent_has_not_already_answered_question
  validate :cant_vote_own_poll

  belongs_to(
    :respondent,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => "User"
  )

  belongs_to(
    :answer_choice,
    :primary_key => :id,
    :foreign_key => :answer_choice_id,
    :class_name => "AnswerChoice"
  )


  def cant_vote_own_poll
    if self.poll_owner.first.id == self.user_id
      errors[:user_id] << "Can't vote on your own poll!"
    end
  end

  def poll_owner
    User.select('users.*')
    .joins(:authored_polls => [{:questions => :answer_choices}])
    .where("answer_choices.id = ?" , self.answer_choice_id)
  end

  def respondent_has_not_already_answered_question
    if existing_responses.count > 1
      errors[:user_id] << "This user id already answered the question"
    end
  end

  def existing_responses
    query_hash = {
      :answer_choice_id => self.answer_choice_id,
      :user_id => self.user_id
    }
    Response.find_by_sql([<<-SQL, query_hash])
      SELECT
        responses.*
      FROM
        responses
      JOIN
        answer_choices
      ON
        responses.answer_choice_id = answer_choices.id
      WHERE
        responses.user_id = :user_id
      AND
        answer_choices.question_id IN
        (SELECT
          question_id
        FROM
          'answer_choices'
        WHERE
          id = :answer_choice_id
        )
    SQL
  end
end