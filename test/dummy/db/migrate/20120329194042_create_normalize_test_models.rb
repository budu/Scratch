class CreateNormalizeTestModels < ActiveRecord::Migration
  def change
    create_table :normalize_test_models do |t|
      t.string :foo
      t.integer :bar
      t.text :baz
    end
  end
end
