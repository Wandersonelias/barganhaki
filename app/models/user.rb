class User < ApplicationRecord
  has_many :products
  has_one :company
  
  enum status: {:Vendedor => 0, :Comprador => 1}
  scope :salers_actives, -> { where(status: 0)}
  #role: ["comprador", "vendedor"]
  #permissao: ["sim", "nao"]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
