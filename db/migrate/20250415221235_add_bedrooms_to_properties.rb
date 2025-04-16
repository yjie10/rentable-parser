class AddBedroomsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :bedrooms, :float
  end
end
