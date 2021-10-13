class ExpireUserPassword < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.datetime :password_changed_at
    end
    add_index :users, :password_changed_at
  end
end
