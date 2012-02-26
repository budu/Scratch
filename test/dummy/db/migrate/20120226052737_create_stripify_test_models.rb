class CreateStripifyTestModels < ActiveRecord::Migration
  def change
    create_table :stripify_test_models do |t|
      t.string :foo
      t.string :bar
    end
  end
end
