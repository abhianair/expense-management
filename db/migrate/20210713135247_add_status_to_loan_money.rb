class AddStatusToLoanMoney < ActiveRecord::Migration[6.1]
  def change
    add_column :loan_moneys, :status, :integer, :default=> 0
  end
end
