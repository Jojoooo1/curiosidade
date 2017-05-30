class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :next_url
      t.string :previous_url
      t.string :slug

      t.timestamps
    end
  end
end
