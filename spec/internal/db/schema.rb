# frozen_string_literal: true

ActiveRecord::Schema.define do
  # Set up any tables you need to exist for your test suite that don't belong
  # in migrations.
  create_table 'grandmas', force: true do |t|
    t.string 'name'
  end

  create_table 'mock_apple_pies', force: true do |t|
    t.integer 'grandma_id'
    t.string  'ingredients'
  end
end
