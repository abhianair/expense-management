module ApplicationHelper

  def current_user_account_balance
    current_user.user_meta.first.present? ? current_user.user_meta.first.account_balance : 0
  end

  def current_user_account_expense
    current_user.user_meta.first.present? ? current_user.user_meta.first.expense : 0
  end


end
