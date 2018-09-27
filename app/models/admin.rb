class Admin < ApplicationRecord
  enum role: ["Acesso Total", "Acesso Parcial"]
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #pesquisas para filtragem de informações
  scope :com_acesso_total, -> { where(role: 0)}
  scope :com_acesso_restrito, -> { where(role: 1)}

  
end
