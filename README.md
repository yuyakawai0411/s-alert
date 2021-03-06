<!-- omit in toc -->
# :necktie: S-alert
[![Image from Gyazo](https://i.gyazo.com/838a280b802f6ce5047a1c1c8d9c1392.jpg)](https://gyazo.com/838a280b802f6ce5047a1c1c8d9c1392)

<a id="top"></a>

<!-- omit in toc -->
# :pushpin:目次
- [:page_facing_up: アプリケーション概要](#page_facing_up-アプリケーション概要)
- [:globe_with_meridians: デモンストレーション](#globe_with_meridians-デモンストレーション)
- [:thought_balloon: 制作背景](#thought_balloon-制作背景)
- [:computer:利用方法](#computer利用方法)
- [:package: 機能一覧](#package-機能一覧)
- [:video_game: 実装機能の画像](#video_game-実装機能の画像)
- [:tractor: インフラ構成](#tractor-インフラ構成)
- [:floppy_disk: テーブル設計](#floppy_disk-テーブル設計)
- [:mortar_board:使用技術一覧](#mortar_board使用技術一覧)
- [:wrench: 今後の改善点](#wrench-今後の改善点)
- [:paperclip: ローカルでの動作方法](#paperclip-ローカルでの動作方法)


# :page_facing_up: アプリケーション概要
### **デキるビジネスマン**
何気ない会話の中に含まれる相手のパーソナルなデータ(感情、趣味、生活リズム等)を共有し、営業活動に生かすためのアプリです。いかなる時でも冷静に、相手の感情に応じて、適切な会話・アイスブレイクができるようになります。


相手の情報を名刺として登録することで、以下4つの機能が使えるようになります。
- 感情を予測   
- 着信タイミングを予測 
- 会話のネタを共有 
- メールで通知
### 感情を予想
誕生日をもとに、現在の日付から前後2週間の感情の起伏を計算し、グラフで表示します(バイオリズムによって算出)。また、日々の感情を手動で記録し、理論値と実測値を比較することも可能です。この機能によって、相手の感情に事前に予想することができます。
### 着信タイミングを予測
過去の着信履歴をもとに、着信が多い時間と日付を計算し、グラフで確認できます。突発的な電話を予測し、事前に準備することで冷静に会話することができます。
### 会話のネタを共有
メッセージ機能を用いて、その人にあった会話のネタを共有できます。 
### メールで通知
日付、予定内容、会話のネタを登録すると、指定した日付の朝9:00にメールでリマインドしてくれます。これにより、必要な時に予定内容と会話のネタを確認することができます。

[↑目次](#top)
# :globe_with_meridians: デモンストレーション
## URL
https://yuya5732.com

## テストユーザー
- email:test@gmail.com 
- PS:test5732

[↑目次](#top)
# :thought_balloon: 制作背景
営業同士でお客様のパーソナルなデータを共有し、営業活動に活かしていました。

しかし、データの共有は多くが口伝えや雑談形式であったため、①共有頻度にばらつきがある、②共有相手にばらつきがある、③データが蓄積されない等の問題があり、データを十分に活用できていないと感じました。

そこで、web上でデータ共有の場を設けることで、上記の課題を解決できないかと考えました。本アプリを使うことで、営業とお客様の双方がより良いコミュニケーションができることを望みます。

[↑目次](#top)
# :computer:利用方法
1. **ユーザーの新規登録/ログイン**
  - 新規登録/ログインは、ヘッダーのログインをクリックすると選択できます。(*テストユーザーを使用する方はログインを選択してください)
  - ユーザーの詳細情報は、「トップページ→MENU→ユーザー→詳細をクリック」で確認できます。

2. **名刺の新規投稿/編集/削除**
  - 名刺の新規投稿は、「トップページ→MENU→名刺→新規投稿をクリック」からできます。
  - 名刺の編集/削除は、「トップページ→MENU→名刺→編集→編集する名刺をクリック」からできます。(*自身が投稿した名刺のみ編集可能ですが、今後は特定のチームで編集できる様にする予定です)
  - 名刺の検索は、ヘッダーの検索窓に名前、会社名、部署名を入力するとできます。

3. **感情予測の確認/投稿/削除**
  - 感情予測の確認は、「トップページ→名刺をクリック→詳細ページに移動→感情の起伏」で確認できます。
  - 感情が特に不安定な日を、詳細ページの不安定日に表示しています。
  - 感情の投稿/削除を手動で登録する場合は、「着信履歴→作成&編集→追加する名刺をクリック」からできます。(*着信履歴がない状況で、感情のみを投稿する場合は「着信有無」の選択を「なし」にしてください)

4. **着信タイミング予測の確認/投稿/削除**
  - 着信タイミング予想の確認は、「トップページ→名刺をクリック→詳細ページに移動→着信頻度」で確認できます。
  - 着信が特に多かった時間を、詳細ページの着信時間頻度に表示しています。
  - 着信履歴の投稿/削除は、「着信履歴→作成&編集→投稿する名刺をクリック」からできます。(*着信履歴のみ投稿したい場合は「感情」の選択を「---」にしてください)

5. **会話ネタの投稿**
  - 会話ネタの投稿は、「トップページ→名刺をクリック→詳細ページに移動→会話のネタ→コメント欄にコメントする」からできます。(*投稿は30日を経過すると自動だ削除されます)
  - 趣味ランキングTop3は、コメント一覧の情報をもとに「トップページ→MENU→名刺→編集→編集する名刺をクリック」から編集してください。

6. **メール通知の登録/削除**
  - メール通知の登録/削除は、「トップページ→MENU→ユーザー→メール通知→詳細ページに移動」からできます。

[↑目次](#top)
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

| 機能            | 目的                       | 詳細                                                                            |
| -------------- | -------------------------- | ------------------------------------------------------------------------------ |
| 感情計算機能     | 相手の感情の起伏を計算するため  | 名刺に登録された誕生日と日々の感情変化データから、バイオリズムを計算し、グラフとして表示できる |
| 感情登録機能     | 過去の感情の起伏を記録するため  | 過去の感情を6段階評価で登録し、バイオリズムの理論値と比較することができる                  |
| 不安定日計算機能  | 不安定日(キレやすい)を知るため | 誕生日から計算したバイオリズムから直近の不安定日を算出することができる                     |

## 着信タイミング予測

| 機能             | 目的                      | 詳細                                                     |
| --------------- | ------------------------- | ------------------------------------------------------- |
| 着信履歴管理機能   | 着信履歴を記録し、管理するため | 日々の感情変化と着信履歴の新規投稿、編集、削除ができる           |
| 着信最頻値計算機能 | 着信タイミングを予測するため   | 着信履歴から、電話が多い時間と日付を計算し、グラフとして表示できる |
| CSVインポート機能 | 着信履歴を素早く登録するため   | 着信履歴をcsvファイルにしてインポートできる                    |

## 会話ネタ共有

| 機能           | 目的                                     | 詳細                                                       |
| ------------- | ---------------------------------------- | --------------------------------------------------------- |
| コメント管理機能 | 相手の最近の趣味や話題を共有できるようにするため | 名刺毎にコメントの新規投稿ができる(30日経過すると自動で削除されます) |

## メール通知

| 機能         | 目的                                  | 詳細                                             |
| ----------- | ------------------------------------- | ----------------------------------------------- |
| メール通知機能 | ユーザーが設定した日付にメールで通知するため | 日付を設定するとその日の朝9:00にメールで通知を受け取れる |

[↑目次](#top)
# :video_game: 実装機能の画像
## ユーザーの新規登録/ログイン
[![Image from Gyazo](https://i.gyazo.com/2c16c1d882cbb5afa70827f28d06f300.gif)](https://gyazo.com/2c16c1d882cbb5afa70827f28d06f300)
## 名刺の新規投稿/編集
[![Image from Gyazo](https://i.gyazo.com/766ec814f149409bcbc20e0503144cc6.gif)](https://gyazo.com/766ec814f149409bcbc20e0503144cc6)
## 感情予測と着信タイミング予測のグラフ
### 感情予想グラフ
[![Image from Gyazo](https://i.gyazo.com/289deaf418c4f4b5dd5fb41d9bfabae5.png)](https://gyazo.com/289deaf418c4f4b5dd5fb41d9bfabae5)
### 着信タイミング予想グラフ
[![Image from Gyazo](https://i.gyazo.com/5d27f48e7708238efcef8fbe779e0435.png)](https://gyazo.com/5d27f48e7708238efcef8fbe779e0435)
## 着信履歴及び感情の投稿/削除
### 手動で投稿
[![Image from Gyazo](https://i.gyazo.com/7ac9dece26d53f8d31d5558a12aa3898.gif)](https://gyazo.com/7ac9dece26d53f8d31d5558a12aa3898)
### CSVで投稿
[![Image from Gyazo](https://i.gyazo.com/8a4660ba0320335b799407e8ce5f7c57.gif)](https://gyazo.com/8a4660ba0320335b799407e8ce5f7c57)
## 会話ネタの投稿(Channel使用)
[![Image from Gyazo](https://i.gyazo.com/f27bb234bc838e42eb80012bb4439950.gif)](https://gyazo.com/f27bb234bc838e42eb80012bb4439950)
## メール通知の登録/削除(Cron+ActiveMailer使用)
[![Image from Gyazo](https://i.gyazo.com/c6ed44a3adad7b19b2975b319b127786.gif)](https://gyazo.com/c6ed44a3adad7b19b2975b319b127786)
### メールの文面
[![Image from Gyazo](https://i.gyazo.com/9ed859205a708a6f87301477837ae02e.png)](https://gyazo.com/9ed859205a708a6f87301477837ae02e)
## お気に入り登録
[![Image from Gyazo](https://i.gyazo.com/5cf5b91ab7959bb1f02d2e06a5f7b0fe.gif)](https://gyazo.com/5cf5b91ab7959bb1f02d2e06a5f7b0fe)

[↑目次](#top)
# :tractor: インフラ構成

## インフラ構成図
[![Image from Gyazo](https://i.gyazo.com/d7ae0799b638115cf9dbc7560c04a8d9.png)](https://gyazo.com/d7ae0799b638115cf9dbc7560c04a8d9)

[↑目次](#top)
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
| user_id            | integer | null: false               |

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

[↑目次](#top)
# :mortar_board:使用技術一覧
### バックエンド
- Ruby
- Ruby on Rails(Action Cable/Action Mailer etc)
- MySQL
### フロントエンド
- HTML
- CSS
- Javascript
### インフラ
- AWS(ECS/RDS/S3/ECR/ALB/ACM/Route53/VPC/IAM/CloudWatch etc)
- Docker
- CircleCI
- Nginx
- Unicorn
### テストツール
- Rspec
- Capybara
### その他
- Cron

[↑目次](#top)
# :wrench: 今後の改善点
- [x] EC２にデプロイ
- [x] Dockerの導入
- [x] CircleCI/CDの導入
- [x] CSVで着信履歴をアップロード
- [x] 会話ネタの投稿を非同期にする
- [ ] CSV着信履歴のアップロードが失敗した時に、バリデーションエラーを表示する
- [ ] 着信履歴を一括で複数追加できるようにする
- [ ] 名刺・着信履歴をグループで同時編集できるようにする
- [ ] 着信時間、着信曜日の相関関係をグラフで表示
- [ ] コンテナ内でcronを稼働させる

[↑目次](#top)
# :paperclip: ローカルでの動作方法

## ダウンロードと起動手順
`$ git clone https://github.com/yuyakawai0411/s-alert.git`

`$ cd s-alert`

`$ vi config/master.key` 

`$ cd docker_development`

`$ docker-compose build`

`$ docker-compose up -d`

`$ docker-compose exec web rails assets:precompile `

`$ docker-compose exec web rails db:create db:migrate `

`$ docker-compose exec web rails db:seed `

**ローカルで動かす際にはmasterkeyを配布しますので、お気軽にお申し付けください**

## 開発環境
- Ruby 2.6.5
- Ruby On Rails 6.0.4
- rbenv 1.1.2
- bundler 2.1.4
- whenever 1.0.0
- cron macOS Big Sur 11.4

[↑目次](#top)