class User < ApplicationRecord
  has_secure_password

  has_many :orders

  validates :name, uniqueness: { message: 'Já existe um usuário com esse nome. Por favor, crie com outro nome.' }
end
