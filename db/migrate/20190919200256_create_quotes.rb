class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :icon_url
      t.string :cn_id
      t.string :url
      t.string :value

      t.timestamps
    end
  end
end
