class AddStyleToBeer < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :style
      t.text :description
    end
  end
end
