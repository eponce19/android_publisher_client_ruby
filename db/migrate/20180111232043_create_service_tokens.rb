class CreateServiceTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :service_tokens do |t|
      t.string :token
      t.datetime :token_created_at
      t.datetime :token_expire_at
    end
  end
end
