# == Schema Information
#
# Table name: newsletters
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Newsletter < ActiveRecord::Base
  belongs_to :user
  has_many :emails
end
