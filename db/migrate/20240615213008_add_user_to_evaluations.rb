class AddUserToEvaluations < ActiveRecord::Migration[7.1]
  def change
    add_reference :evaluations, :user, null: false, foreign_key: true
  end
end
