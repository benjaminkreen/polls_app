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

  has_many :questions, :through => :authored_polls, :source => :questions

end