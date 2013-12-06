class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :user_name

      t.timestamps
    end
    add_index :users, :user_name, :uniqe => true
  end
end
