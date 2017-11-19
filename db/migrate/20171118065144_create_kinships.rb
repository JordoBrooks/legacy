class CreateKinships < ActiveRecord::Migration[5.1]
  def change
    create_table :kinships do |t|
      t.integer :user_id
      t.integer :family_id
      t.timestamps
    end
  end
end
