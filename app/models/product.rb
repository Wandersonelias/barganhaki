class Product < ApplicationRecord
  
 

  
  #relacionamentos
  
  belongs_to :category
  belongs_to :user
  belongs_to :company
  

  scope :last_nine, -> {limit(9).order(created_at: :desc)}
  scope :user_product, -> (user) { where(user: user.id)}
  scope :last_five, -> {limit(5).order(created_at: :desc)}
  scope :search, ->(q) {where(:title => params[:q])}
  scope :buscar, ->(q) {where("title LIKE ?","%#{q}%")}
  #validações

  validates_presence_of :title, :description, :pricefor, :priceof, :category

  def image=(value) #overload pesquisar
    if value.is_a?(String)
      super(value)
      small_image = value 
    else
      #debugger
      img = AwsService.upload(value.tempfile.path, value.original_filename)
      super(img)
      self.small_image = AwsService.upload(value.tempfile.path, value.original_filename, "342x225")
    end
  end

  def small_image
    return super if super.present?
    return "/img/aviao.png"
  end
  
  def image
    return super if super.present?
    return "/img/aviao.png"
  end

end
