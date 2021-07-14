class CreateLoanMoneys < ActiveRecord::Migration[6.1]
  def change
    create_table :loan_moneys do |t|
      t.bigint :donor
      t.bigint :recipient
      t.string :description
      t.decimal :amount, :default => 0

      t.timestamps
    end
  end
end
