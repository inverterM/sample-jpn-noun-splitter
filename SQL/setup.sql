-- このsqlファイルがあるカレントディレクトリで，データベースを起動する
-- スーパーユーザーにログイン
-- su
-- MariaDBの起動
-- mysql

-- 文字コードの設定
SET character_set_client     = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_database   = utf8;
SET character_set_filesystem = binary;
SET character_set_results    = utf8mb4;
SET character_set_server     = utf8mb4;

-- データベースの作成
-- DROP DATABASE IF EXISTS qiita_0531;
CREATE DATABASE qiita_0531;
GRANT ALL PRIVILEGES ON qiita_0531.* TO editor@localhost IDENTIFIED BY 'editor_password';
GRANT ALL PRIVILEGES ON qiita_0531.* TO editor@"%"       IDENTIFIED BY 'editor_password';
GRANT SELECT ON         qiita_0531.* TO viewer@localhost IDENTIFIED BY 'viewer_password';
GRANT SELECT ON         qiita_0531.* TO viewer@"%"       IDENTIFIED BY 'viewer_password';
quit;

-- データベースへのログイン
-- mysql --host=localhost --user=editor --password=editor_password qiita_0531
-- mysql --host=localhost --user=viewer --password=viewer_password qiita_0531

-- テーブルの作成
DROP TABLE IF EXISTS sample_data;
SOURCE               sample_data.sql;
DROP TABLE IF EXISTS sample_data2;
SOURCE               sample_data2.sql;

-- テーブルの確認
SELECT * FROM sample_data;
SELECT * FROM sample_data2;
