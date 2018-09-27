class Category < ApplicationRecord
    validates_presence_of :description

    has_attached_file :icon, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/


end
