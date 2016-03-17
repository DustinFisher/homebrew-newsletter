# == Schema Information
#
# Table name: emails
#
#  id            :integer          not null, primary key
#  name          :string
#  newsletter_id :integer
#  send_date     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Email < ActiveRecord::Base
  belongs_to :newsletter
  has_many :links
end
