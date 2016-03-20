# == Schema Information
#
# Table name: links
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  url         :string
#  email_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Link < ActiveRecord::Base
  belongs_to :email
  belongs_to :user
  belongs_to :category

  validates :url, uniqueness: true
end
