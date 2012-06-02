class AddFileExtensionToSoundposts < ActiveRecord::Migration
  def change
    add_column :soundposts, :ext, :string
  end
end
