class CreatePets < ActiveRecord::Migration[5.2]
  def change
      create_table :pets do |t|
        t.string :name, null: false
        t.text :photoUrls, array: true, null: false, default: []
        t.string :status, null: false
      end
  end
end
