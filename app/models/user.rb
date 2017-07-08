class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  has_many :likes
  has_many :relationships
  has_many :friends, through: :relationships

  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_relationships, source: :user

  validates :username, presence: true, uniqueness: true

  def likes?(tweet)
    tweet.likes.where(user_id: id).any?
  end

  has_attached_file :avatar,
    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:attachment/:id/:basename_:style.:extension",
    :default_url => "/images/download.png",
    :styles => {
      :thumb    => ['50x50#',  :jpg, :quality => 70],

    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',

    }
    validates_attachment :avatar,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
end
