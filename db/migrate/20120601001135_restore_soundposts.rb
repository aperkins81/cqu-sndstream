class RestoreSoundposts < ActiveRecord::Migration
  def change
    #change_column :soundposts, :content, :binary
    # 
    # The above gives this error:
    # PGError: ERROR:  column "content" cannot be cast to type bytea
    # : ALTER TABLE "soundposts" ALTER COLUMN "content" TYPE bytea
    
    remove_column :soundposts, :content
    add_column :soundposts, :content, :binary
  end
end
