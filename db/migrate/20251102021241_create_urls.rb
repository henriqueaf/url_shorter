class CreateUrls < ActiveRecord::Migration[8.1]
  def change
    create_table :urls, id: false do |t|
      t.string :short_code, primary_key: true, null: false
      t.text :long_url, null: false

      t.datetime :created_at, null: false
    end
  end
end
