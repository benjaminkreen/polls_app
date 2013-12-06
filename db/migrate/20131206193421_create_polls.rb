class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text :title
      t.text :author_id

      t.timestamps
    end
    add_index :polls, :author_id
  end
end
