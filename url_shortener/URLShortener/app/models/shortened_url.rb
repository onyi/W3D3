# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :visitor


  

  def self.random_code
    SecureRandom.urlsafe_base64
  end

  def self.create_short_url(user, long_url) #user is a User object, long_url is a string type.
    short_url = ShortenedUrl.random_code
    while ShortenedUrl.exists?(short_url: short_url)
      short_url = ShortenedUrl.random_code
    end 
    ShortenedUrl.create!(user_id: user.id, short_url: short_url, long_url: long_url)
  end

end
