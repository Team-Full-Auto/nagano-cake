# Nagano-cake
≪ながのCAKE≫ケーキ店の通販販売を行うためのECサイト

# 概要
顧客側の機能

* 会員アカウントの作成を行わず商品の閲覧が可能

* 通販を利用する際はお客様に会員アカウントの作成をして頂き商品をカートに入れ注文が可能

* 商品の配送先は自宅の住所以外にも登録でき、離れたご家族へのプレゼントとして配送することが可能

* 自身の注文履歴の閲覧が可能 

* 注文から配送完了までステータスとして確認が可能

管理者側の機能

* 商品、ジャンル、会員情報まで編集可能

* 注文履歴の確認が可能 

* お客様からの注文の管理、配送までの管理が可能


# 機能
* デバイスを使用したログイン機能

* gemを使用せず顧客側と管理者側の実装

* enumの実装

* kaminariの実装

* bootstrap の実装

# 

# 使い方
会員側、管理者側ログインはメールアドレスを

会員の場合は新規作成を行い好きなアカウント作成して利用可能

# バージョン
* Ruby 3.1.2　rails 6.1.7.3

# インストール
$ git clone git@github.com:chibaragi/nagano-cake.git

$ rails db:migrate
$ bundle install


# 作者
青谷優次　福田拓矢　大塚雅也
