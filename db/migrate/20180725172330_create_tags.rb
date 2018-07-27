class CreateTags < ActiveRecord::Migration[5.2]
  def change
      create_table :tags do |t|
        t.belongs_to :pet, index: true
        t.string :name, null: false
        t.timestamps
      end
  end
end
