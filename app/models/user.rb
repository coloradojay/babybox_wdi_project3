
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :children
	has_many :boxes
	has_many :products, through: :boxes

  # Validations
<<<<<<< HEAD
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, uniqueness: true


