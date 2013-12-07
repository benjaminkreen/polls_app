class User < ActiveRecord::Base

  validate :user_name, :presence => true, :uniqueness => true

  has_many(
    :authored_polls,
    :primary_key => :id,
    :foreign_key => :author_id,
    :class_name => "Poll"
  )

  has_many(
    :responses,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => "Response"
  )

  def completed_polls
    # Polls.select("polls.*, COUNT(response.user_id) tally")
    # .joins(:question => :response).where('response.id = ?', self.id)
    # .group("Polls.id")

    tally = Poll.find_by_sql([<<-SQL, self.id])
    SELECT
  polls.*, COUNT(questions.id) question_count, sub.user_response_count user_count
  FROM
  polls
  JOIN
  questions
  ON
  polls.id = questions.poll_id
  JOIN
  (SELECT
  polls.id id, polls.title AS title , COUNT(responses.user_id) AS user_response_count
    FROM
    polls
    JOIN
    questions
    ON
    polls.id = questions.poll_id
    JOIN
    answer_choices
    ON
    questions.id = answer_choices.question_id
    JOIN
    responses
    ON
    answer_choices.id = responses.answer_choice_id
    WHERE
    responses.user_id = ?
    GROUP BY
  polls.id) AS sub
  ON
  polls.id = sub.id
    SQL
    output = []

    p tally
    # tally.each do |poll_data|
   #    output << [poll_data.name, poll_data.question_count, poll_data.user_count]
   #  end
   #  output
  end
end