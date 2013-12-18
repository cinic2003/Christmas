class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :giving
      t.string :who
      t.boolean :is_done

      t.timestamps
    end
  end
end
