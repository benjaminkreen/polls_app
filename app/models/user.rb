class User < ActiveRecord::Base

  validate :user_name, :presence => true


end