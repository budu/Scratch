class CreateNilifyTestModels < ActiveRecord::Migration
  def change
    create_table :nilify_test_models do |t|
      t.string :foo
      t.string :bar
      t.integer :baz
    end
  end
end
