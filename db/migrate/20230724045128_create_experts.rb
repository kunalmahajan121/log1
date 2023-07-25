class CreateExperts < ActiveRecord::Migration[6.0]
  def change
    create_table :experts do |t|

      t.string :expert_name
      t.string :expert_skill
      t.text :description

      t.timestamps
    end
  end
end
