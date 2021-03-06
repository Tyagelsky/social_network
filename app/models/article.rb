class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  default_scope -> { order('created_at DESC') }
  validates :user_id, :label, presence: true
  validates :body ,  presence: true, length: { maximum: 250 }
  has_attached_file :file
  do_not_validate_attachment_file_type :file

    def self.from_users_followed_by(user)
      followed_user_ids = "SELECT followed_id FROM relationships
                           WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
            user_id: user.id)
    end
end
