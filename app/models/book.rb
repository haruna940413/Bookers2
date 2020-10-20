class Book < ApplicationRecord
  
  validates :title, {presence: true,length: {maximum: 200}}
  validates :body, {presence: true,length: {maximum: 200}}
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end
   
   
   #検索で使うメソッド 
   
  def self.search(method,word)
   if method == "forward_match"
      @books = Book.where("title LIKE?","#{word}%")
   elsif method == "backward_match"
      @books = Book.where("title LIKE?","%#{word}")
   elsif method == "perfect_match"
      @books = Book.where("title LIKE?", "#{word}")
   elsif method == "partial_match"
      @books = Book.where("title LIKE?","%#{word}%")
   else
      @books = Book.all
   end
  end
  
end
