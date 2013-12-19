class AddHashToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :token, :string
  end
end
