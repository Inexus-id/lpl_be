class Clan < ActiveRecord::Base
  attr_accessible :name
  has_many :enrollments
end
