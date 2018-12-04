class Company < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :products
  
# metodos de upload de imagem  
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
    return "/img/noimage.png"
  end
  
  def image
    return super if super.present?
    return "/img/aviao.png"
  end

end
