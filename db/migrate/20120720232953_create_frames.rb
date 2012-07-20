class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :first_roll
      t.integer :second_roll
      t.integer :third_roll
      t.integer :pins_left, :default => 10
      t.integer :score, :default => 0
      t.string :mark, :default => 'open'

      t.timestamps
    end
  end
end
