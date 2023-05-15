class Space < ApplicationRecord
  
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def average_rating
    reviews.average(:rating).to_f
  end
  
  def self.search(keyword)
    if keyword
      Space.where(["name LIKE(?) OR address LIKE(?) OR transportation LIKE(?) ", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    else
      Space.all
    end
  end
  
  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  
  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "end_time", "genre_id", "id", "introduction", "is_active", "latitude", "longitude", "name", "outlet", "private_room", "smoking", "start_time", "transportation", "parking", "telephone_number", "updated_at", "website", "wifi"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["favorites", "genre", "image_attachment", "image_blob", "reviews", "space_tags"]
  end
  
  

end
