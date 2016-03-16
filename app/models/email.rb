class Email < ActiveRecord::Base
  belongs_to :newsletter
  has_many :links
end
