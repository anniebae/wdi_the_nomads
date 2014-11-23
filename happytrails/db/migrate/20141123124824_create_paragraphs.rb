class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.text :body
      t.integer :index
      t.references :trail

      t.timestamps
    end
  end
end
