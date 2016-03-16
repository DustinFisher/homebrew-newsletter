class Newsletter < ActiveRecord::Base
  belongs_to :user
  has_many :emails
end
