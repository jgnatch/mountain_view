class CreateSomethings < ActiveRecord::Migration
  def change
    create_table :somethings do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
