class Product < ApplicationRecord
  include Paperclip::Glue
  
  #relacionamentos
  
  belongs_to :category
  belongs_to :user
  

  #funcao para linkar itens a produtos
=begin
  before_destroy :ensure_not_referenced_by_any_item

  private
  def ensure_not_referenced_by_any_item
    if item.empty?
        return true
    else
      errors.add(:base, 'Produtos estao presentes')
      return false
    end
  
  end
=end

  #Scopes

  scope :last_nine, -> {limit(9).order(created_at: :desc)}
  scope :user_product, -> (user) { where(user: user.id)}
  scope :last_five, -> {limit(5).order(created_at: :desc)}
  scope :search, ->(q) {where(:title => params[:q])}
  scope :buscar, ->(q) {where("title LIKE ?","%#{q}%")}
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
