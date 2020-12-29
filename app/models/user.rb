class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :validatable, :confirmable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :lockable, :registerable

  has_many :headcounts, dependent: :destroy
end
