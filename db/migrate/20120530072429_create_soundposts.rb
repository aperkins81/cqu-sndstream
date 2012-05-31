class CreateSoundposts < ActiveRecord::Migration
  def change
    create_table :soundposts do |t|
      t.binary :content
      t.integer :user_id

      t.timestamps
    end
    add_index :soundposts, [:user_id, :created_at]
  end
end
