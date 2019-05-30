# == Schema Information
#
# Table name: visits
#
#  id           :bigint           not null, primary key
#  short_url_id :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Visit < ApplicationRecord
  validates :user_id, :short_url_id, presence: true

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :visited_urls,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl

  def self.record_visit!(user, shortened_url) #user is a object and shortened_url is a string.

  end
end
