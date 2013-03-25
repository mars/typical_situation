class CreateGrandmas < ActiveRecord::Migration
  def up
    create_table :grandmas do |t|
      t.string :name
    end
  end

  def down
    drop_table :grandmas
  end
end
