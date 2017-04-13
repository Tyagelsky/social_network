class Article < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, :label, presence: true
  validates :body ,  presence: true, length: { maximum: 250 }
  
end
