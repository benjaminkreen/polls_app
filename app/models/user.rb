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
    Polls.select("polls.*, COUNT(response.user_id) tally")
    .joins(:question => :response).where('response.id = ?', self.id)
  end


end