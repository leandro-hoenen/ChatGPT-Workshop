class CreateEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :evaluations do |t|
      t.integer :accuracy
      t.text :accuracy_description
      t.integer :relevance
      t.text :relevance_description
      t.integer :bias
      t.text :bias_description
      t.text :comments
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
