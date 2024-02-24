class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :event_name, presence: true
  # 写真が必ずしも必要ではないと思っているのでコメントアウト
  # validates :image, presence: true
  validates :caption, presence: true, length: { maximum:1000 }
  validates :category, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
    # post_image.indexの画像サイズ設定 
  def get_thumbnail(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    # 受け取った引数のサイズに変換 [width, height]、1/2サイズで表示
    image.variant( gravity: :center, resize: "#{width}x#{height}", crop: "#{width / 2}x#{height / 2}+0+0" ).processed
  end
  

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      PostImage.where(event_name: content)
    elsif method == 'forward'
      PostImage.where('event_name LIKE ?', content + '%')
    elsif method == 'backward'
      PostImage.where('event_name LIKE ?', '%' + content)
    else
      PostImage.where('event_name LIKE ?', '%' + content + '%')
    end
  end

end
