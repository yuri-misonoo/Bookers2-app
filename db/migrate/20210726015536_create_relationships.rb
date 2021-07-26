class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, type: :integer, foreign_key: true
      t.references :follow, type: :integer , foreign_key: {to_table: :users}

      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
      
    end
  end
end
