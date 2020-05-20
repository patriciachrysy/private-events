class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :event_date
      t.string :name
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
