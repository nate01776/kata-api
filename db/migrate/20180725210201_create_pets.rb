class CreatePets < ActiveRecord::Migration[5.2]
  def change
      create_table :pets do |t|
        t.belongs_to :category, index: true
        t.string :name
        t.text :photoUrls
        t.text :tags, array: true, default: []
        t.string :status
        t.timestamps
      end
  end
end
