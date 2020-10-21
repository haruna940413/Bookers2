class Relationship < ApplicationRecord
  validates :follower_id, presence: true  # フォロー取得(自分がフォローしてる人)
  validates :followed_id, presence: true  # フォロワー取得(自分をフォローしてる人)
 
  belongs_to :follower, class_name: "User"  #ユーザークラスから情報取ってきたもの
  belongs_to :followed, class_name: "User"
end
