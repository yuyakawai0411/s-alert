# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | unique: true, null: false |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| company            | string | null: false               |
| department         | string | null: false               |

### Association

- has_many :cards
- has_many :favorites


## cards テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| last_name        | string     | null: false                    |
| first_name       | string     | null: false                    |
| last_name_kana   | string     | null: false                    |
| first_name_kana  | string     | null: false                    |
| company          | string     | null: false                    |
| department       | string     | null: false                    |
| phone_number     | string     | null: false                    |
| birth_day        | date       | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :records
- has_one :favorite


## records テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| day           | date       | null: false                    |
| time_id       | string     | null: false                    |
| expression_id | string     | null: false                    |
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