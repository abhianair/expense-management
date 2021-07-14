class AddPaidTsToLoneMoneys < ActiveRecord::Migration[6.1]
  def change
    add_column :loan_moneys, :paid_ts, :datetime
  end
end
