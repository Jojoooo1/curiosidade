class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.references :article, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
