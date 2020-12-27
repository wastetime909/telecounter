class CreateHeadcounts < ActiveRecord::Migration[6.0]
  def change
    create_table :headcounts do |t|
      t.integer :current_count, default: 0 
      t.integer :max_count, default: 100
      t.string :qr_code
      t.string :entrance_code
      t.string :exit_code 
      t.string :stamp
      t.string :nickname
      t.integer :pass_code
      t.references :user, foreign_key: true 

      t.timestamps
    end
  end
end
