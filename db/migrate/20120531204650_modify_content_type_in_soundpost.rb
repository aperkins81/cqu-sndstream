class ModifyContentTypeInSoundpost < ActiveRecord::Migration
  def up
    change_column :soundposts, :content, :text
  end

  def down
    change_column :soundposts, :content, :binary
  end
end
