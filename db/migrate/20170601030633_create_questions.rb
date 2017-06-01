class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :questions do |t|
      t.string :type
      t.text :body, null: false
      t.hstore :options, default: '', null: false

      t.timestamps
    end
  end
end
