class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :user_meta
  has_many :expenses

  has_many :transactions, :class_name => "LoanMoney", foreign_key: :donor
  has_many :recipients, through: :transactions #who ows you money


  def total_owes
    return self.transactions.where.not(:status => 2).sum(:amount)
  end



end
