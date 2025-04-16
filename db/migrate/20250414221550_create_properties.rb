class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :property_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
