class AddFileTypeToSoundposts < ActiveRecord::Migration
  def change
    add_column :soundposts, :filetype, :string
  end
end
