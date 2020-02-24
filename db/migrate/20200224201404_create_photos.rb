class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.text :caption
      t.integer :comments_count, {:default=> 0}
      t.string :image
      t.integer :owner_id

      t.timestamps
    end
  end
end
