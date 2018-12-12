class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.string :email
      t.string :resposta

      t.timestamps
    end
  end
end
