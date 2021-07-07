# :necktie: S-alert

# :page_facing_up: アプリケーション概要
### **デキるビジネスマン**


それは、いかなる時でも冷静に、相手の感情に応じて、適切な会話・アイスブレイクができる人だと思います。このアプリは、そんなデキるビジネスマンになるためのものです。
相手の情報を名刺として登録することで、以下4つの機能が使えるようになります。
- 感情を予測   
- 連絡タイミングを予測 
- 会話のネタを共有 
- メールで通知
### 感情を予想
誕生日をもとに、現在の日付から前後2週間の感情の起伏を計算し、グラフで表示します(バイオリズムによって算出)。また、日々の感情を手動で記録し、理論値と実測値を比較することも可能です。この機能によって、相手の感情に事前に予想することができます。
### 連絡タイミングを予測
過去の通話履歴をもとに、通話が多い時間と日付を計算し、グラフで確認できます。突発的な電話を予測し、事前に準備することで冷静に会話することができます。
### 会話のネタを共有
メッセージ機能を用いて、その人にあった会話のネタを共有できます。 
### メールで通知
日付を選択し、予定内容と会話のネタを登録すると、指定した日時にメールでリマインドしてくれます。これにより、必要な時に予定内容と会話のネタを確認することができます。

# :globe_with_meridians: デモ
## URL
https://s-alert.herokuapp.com/
## テスト用アカウント
- BASIC 認証
  - ID:yuya
  - PS:5732 
- テストユーザー
  - email:test@gmail.com 
  - PS:5732test

# :thought_balloon: 目指した課題解決
このアプリはビジネスマンが上司や顧客と会話するときに抱える3つの課題を解決します。
- 場をなごませたいものの、会話のネタが思いつかない 
- 頼み事や相談する時など、相手の機嫌に応じて対応を変えたい 
- スムーズに会話・回答できるよう、突発的な確認電話を予測したい

# :computer:利用方法
## ユーザー登録
1. 新規登録
1. ログイン

## お気に入り
1. お気に入りの登録/解除
1. お気に入りの確認

## 名刺登録
1. 名刺の投稿
1. 名刺を編集/削除

## 名刺検索
1. 名刺の検索

## 感情予測
1. 手動で感情を投稿/削除
1. 感情の起伏を確認

## 連絡タイミング予測
1. 通話履歴の投稿/削除
1. 通話頻度を確認

## 会話のネタ共有
1. 会話ネタの投稿/削除
1. 会話のネタTop3の編集

## メール通知
1. メール通知の登録/削除


# :package: 機能一覧
## ユーザー

| 機能           | 目的                                          | 詳細                                                |
| ------------- | --------------------------------------------- | -------------------------------------------------- |
| ユーザー管理機能 | ユーザー登録した人がサービスを利用できるようにするため | ユーザー新規登録、ログインができる                       |
| ユーザー詳細    | ユーザーの詳細を閲覧できるようにするため             | ユーザーのプロフィール、投稿一覧、お気に入り一覧が確認できる |
| お気に入り機能  | お気に入りの名刺を見失わないようにするため            | お気に入りの名刺ををユーザー毎に保存できる                |

## 名刺

| 機能        | 目的                         | 詳細                                         |
| ---------- | ---------------------------- | ------------------------------------------- |
| 名刺管理機能 | 相手の情報を名刺として管理するため | 名刺の新規投稿、編集、削除ができる                |
| 名刺検索機能 | 名刺を素早く見つけるため         | 投稿されている名刺を名前、会社名、部署名で検索できる |

## 感情予測

| 機能        | 目的                      | 詳細                                                                            |
| ---------- | ------------------------- | ------------------------------------------------------------------------------ |
| 感情計算機能 | 相手の感情の起伏を計算するため | 名刺に登録された誕生日と日々の感情変化データから、バイオリズムを計算し、グラフとして表示できる |
| 感情登録機能 | 過去の感情の起伏を記録するため | 過去の感情を6段階評価で登録し、バイオリズムの理論値と比較することができる                  |

## 連絡タイミング予測

| 機能             | 目的                                    | 詳細                                                    |
| --------------- | -------------------------------------- | ------------------------------------------------------- |
| 通話履歴管理機能   | 相手の感情変化と通話履歴を記録し、管理するため | 日々の感情変化と着信履歴の新規投稿、編集、削除ができる           |
| 通話最頻値計算機能 | 名刺を素早く見つけるため                    | 着信履歴から、電話が多い時間と日付を計算し、グラフとして表示できる |

## 会話ネタ共有

| 機能           | 目的                                     | 詳細                                                       |
| ------------- | ---------------------------------------- | --------------------------------------------------------- |
| コメント管理機能 | 相手の最近の趣味や話題を共有できるようにするため | 名刺毎にコメントの新規投稿ができる(30日経過すると自動で削除されます) |

## メール通知

| 機能         | 目的                                  | 詳細                                                       |
| ----------- | ------------------------------------- | --------------------------------------------------------- |
| メール通知機能 | ユーザーが設定した日付にメールで通知するため | 名刺毎にコメントの新規投稿ができる(30日経過すると自動で削除されます) |


# :video_game: 実装した機能についての画像


# :wrench: 実装予定の機能
- [ ] EC２にデプロイ
- [ ] Dockerの導入
- [ ] CircleCI/CDの導入
- [ ] CSVの通話履歴をアプリにアップロードできる
- [ ] コメント機能にいいね機能をもたせ、いいねの数に応じたランキングを表示
- [ ] スクレイピング機能を用いて、登録された会話のネタに関するニュースを自動収集


# :floppy_disk: テーブル設計

## ER図
[![Image from Gyazo](https://i.gyazo.com/3fa8f8decec7266b3b85d7b036440a78.png)](https://gyazo.com/3fa8f8decec7266b3b85d7b036440a78)


## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | unique: true, null: false |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| company            | string  | null: false               |
| company_form_id    | integer | null: false               |
| department         | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many :cards
- has_many :favorites
- has_many :notices
- has_many :comments


## cards テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| s_last_name       | string     | null: false                    |
| s_first_name      | string     | null: false                    |
| s_last_name_kana  | string     | null: false                    |
| s_first_name_kana | string     | null: false                    |
| s_company         | string     | null: false                    |
| s_company_form_id | integer    | null: false                    |
| s_department      | string     | null: false                    |
| s_phone_number    | string     | null: false                    |
| s_birth_day       | date       | null: false                    |
| s_hobby_top       | string     |                                |
| s_hobby_medium    | string     |                                |
| s_hobby_row       | string     |                                |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :records
- has_many :favorite
- has_many :comments


## records テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| date          | date       | null: false                    |
| phone_time_id | integer    | null: false                    |
| expression_id | integer    | null: false                    |
| phone_call_id | integer    | null: false                    |
| card          | references | null: false, foreign_key: true |

### Association

- belongs_to :card


## favorites テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| card          | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :card


## Notices テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| notice_date   | date       | null: false                    |
| description   | string     | null: false                    |
| topic         | string     |                                |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user


## comments テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| text          | string     | null: false                    |
| card          | references | null: false, foreign_key:true  |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user 
- belongs_to :card

# :paperclip: ローカルでの動作方法

## ダウンロードとインストールの手順
1. このリポジトリのクローンを作成してください


`$ git clone https://github.com/yuyakawai0411/s-alert.git`
1. リポジトリに移動してください


`$ cd s-alert`
1. 依存関係をインストールしてください


`$ bundle install`
`$ yarn install`
1. データベースを作成してください


`$ rails db:create`
1. データベースを実行してください


`$ rails db:migrate`
1. seedファイルを実行してください


`$ rails db:seed`
1. アプリケーションを実行してください


`$ rails s`

## 開発環境
- Ruby 2.6.5
- Ruby On Rails 6.0.4
- rbenv 1.1.2
- bundler 2.1.4