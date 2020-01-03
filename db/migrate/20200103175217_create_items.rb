class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.date :loan_date
      t.date :return_date
      t.references :user, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
