class CreateMockApplePies < ActiveRecord::Migration
  def up
    create_table :mock_apple_pies do |t|
      t.integer :grandma_id
      t.string :ingredients
    end
  end

  def down
    drop_table :mock_apple_pies
  end
end
