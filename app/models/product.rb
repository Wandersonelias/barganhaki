class Product < ApplicationRecord
  
 
  enum situation: {:Disponivel => 0, :Indisponivel => 1, :Oferta => 2}
  #enum situation: [:Disponivel, :Indisponivel, :Promocao]
  

  #relacionamentos
  
  belongs_to :category
  belongs_to :user
  belongs_to :company
  
  

  scope :last_nine, -> {limit(9).order(created_at: :desc)}
  scope :user_product, -> (user) { where(user: user.id)}
  scope :last_five, -> {limit(5).order(created_at: :desc)}
  scope :search, ->(q) {where(:title => params[:q])}
  scope :buscar, ->(q) {where("title LIKE ?","%#{q}%")}
  scope :list_products_type, -> {where(situation: 2)}

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
