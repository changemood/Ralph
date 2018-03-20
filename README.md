# README

## バージョン
* Ruby version 2.4.0
* Rails version 5.1.4

## DB
* postgresql
 
## 環境構築手順
1. repositoryをクローン  
  `$ git clone https://github.com/changemood/ralphs-api` 

2. redis, postgresのインストール  
*redisは、sidekiq(background job)用  
redis: [https://qiita.com/checkpoint/items/58b9b0193c0c46400eeb](https://qiita.com/checkpoint/items/58b9b0193c0c46400eeb)  
postgres: [https://qiita.com/_daisuke/items/13996621cf51f835494b](https://qiita.com/_daisuke/items/13996621cf51f835494b)  
**インストール後に起動すること**



3. Ruby, Rails, bundlerをインストール  
  Ruby: [rbenvを使ってRubyをインストール](https://dev.classmethod.jp/server-side/language/build-ruby-environment-by-rbenv/)  
        [rvmを使ってRubyをインストール(高橋はコチラ)](https://qiita.com/yukofeb/items/6cad3a6de48dab60889b)  
   Rails: [http://installrails.com/steps/choose_os_version](http://installrails.com/steps/choose_os_version)  
   bundler: `$ gem install bundler`  

4. Gemのインストール  
`$ bundle install`

5. DB構築  
`$ rake db:create db:migrate db:seed`

6. rails app を起動  
`$ foreman start`  
**rails sでも起動できるが、その際は、sidekiqを別で起動すること**  
(参考: [foreman で アプリケーションを動かす](https://qiita.com/7kaji/items/6a59977d2ad85604e7fd))


# TODO
- rspecのテストをかく
- SrEvent のintervalをどのようにするか(ユーザー？こちら側？2回目以降のremindのinterval？)
- メールのレイアウト・デザインの変更

**(注)やらないといけないことがあった場合は、こちらに書き込んでいく、またはissueを作ること**

# DONE
- user モデル作成
- board モデル作成
- card モデル作成
- sr_event モデル作成
- sr remind用のmailer jobの作成
