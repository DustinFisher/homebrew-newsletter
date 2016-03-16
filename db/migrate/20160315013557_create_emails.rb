class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :name
      t.references :newsletter, index: true, foreign_key: true
      t.datetime :send_date

      t.timestamps null: false
    end
  end
end
