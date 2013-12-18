class AddTalkToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :talk, :string
  end
end
