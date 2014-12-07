class AddTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.timestamps
    end

    create_table :sizes do |t|
      t.string :name
    end

    create_table :intervals do |t|
      t.string :name
    end

    create_table :tasks do |t|
      t.string :text
      t.datetime :done
      t.references :user
      t.references :size
      t.references :interval
    end
  end
end
