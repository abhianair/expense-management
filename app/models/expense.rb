class Expense < ApplicationRecord
  belongs_to :user

  after_create :update_account_balance


  def update_account_balance
    user_meta = self.user.user_meta.first()
    user_meta.update(:account_balance => user_meta.account_balance - self.amount, :expense => user_meta.expense + self.amount)
  end

end
