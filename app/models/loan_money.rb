class LoanMoney < ApplicationRecord
  include ActiveModel::Dirty
  # define_attribute_methods :status

  belongs_to :recipient, :class_name => "User", foreign_key: :recipient
  belongs_to :donor, :class_name => "User", foreign_key: :donor

  after_create :update_account_balance

  enum status: [:pending, :write_off, :paid_back]

  def paid?
    paid_ts != nil ? true : false
  end

  def update_account_balance
    user_meta = self.donor.user_meta.first
    user_meta.update(:account_balance => (user_meta.account_balance - self.amount.to_f))
  end

end
