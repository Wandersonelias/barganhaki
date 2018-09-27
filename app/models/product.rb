class Product < ApplicationRecord
  include Paperclip::Glue
  belongs_to :category
  belongs_to :user


  #Scopes

  scope :last_nine, -> {limit(9).order(created_at: :desc)}
  scope :user_product, ->(user) { where(user: user)}
  scope :last_five, -> {limit(5).order(created_at: :desc)}

  #validações

  validates_presence_of :title, :description, :pricefor, :priceof, :image, :category


  #Paperclip

  has_attached_file :image,
  :styles => {
    :original => [:png],
    :small    => ['100x100#', :png],
    :medium   => ['350x197#',  :png],
    :post     => ['478x243#', :png],
    :facebook => ['600x600#', :png]
  }, default_url: "/image/:style/missing.png"
  validates_attachment_content_type :image, content_type: ["image/jpeg", "image/gif", "image/png"]
  #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
