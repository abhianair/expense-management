class CreateUserMeta < ActiveRecord::Migration[6.1]
  def change
    create_table :user_meta do |t|
      t.decimal :account_balance, default: 0
      t.decimal :expense, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
