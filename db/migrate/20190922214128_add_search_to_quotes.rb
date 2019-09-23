class AddSearchToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :quotes, :search, foreign_key: true
  end
end
