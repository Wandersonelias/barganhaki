class Category < ApplicationRecord
    validates_presence_of :description

    #has_attached_file :icon, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
    #validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/


#tornando url amigaveis para SEO

  def icon=(value) #overload pesquisar
    if value.is_a?(String)
      super(value)
       
    else
      img = AwsService.upload(value.tempfile.path, value.original_filename, "50x50")
      super(img)
      
    end
  end

  
  
  def icon
    return super if super.present?
    return "/img/aviao.png"
  end

end
