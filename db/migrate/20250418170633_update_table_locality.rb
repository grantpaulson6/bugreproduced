class UpdateTableLocality < ActiveRecord::Migration[7.1]
  def up
    execute "ALTER DATABASE bugtestonly SET PRIMARY REGION 'aws-us-west-2'"
    execute 'ALTER TABLE posts SET LOCALITY REGIONAL BY ROW;'
  end

  def down
    execute 'ALTER TABLE posts SET LOCALITY REGIONAL;'
  end
end
