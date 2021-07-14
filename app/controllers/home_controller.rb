class HomeController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def add_account_balance
    if current_user.user_meta.present?
      user_meta = current_user.user_meta.first
      account_balance = user_meta.account_balance
      user_meta.update_attribute('account_balance', (account_balance + params['amount'].to_f))
    else
      current_user.user_meta.create(account_balance: params['amount'].to_f)
    end
  end
  
end
