# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Users（ユーザー情報）

| Column              | Type    | Options                          |
|---------------------|---------|----------------------------------|
| name                | string  | null: false                      |
| email               | string  | null: false, unique: true        |
| encrypted_password  | string  | null: false                      |
| last_name           | string  | null: false                      |
| first_name          | string  | null: false                      |
| kana_last_name      | string  | null: false                      |
| kana_first_name     | string  | null: false                      |
| birthday            | date    | null: false                      |

### Association
- has_many :items
- has_many :buyers


Items（商品情報）

| Column                      | Type      | Options                          |
|-----------------------------|-----------|----------------------------------|
| title                       | string    | null: false                      |
| description                 | text      | null: false                      |
| category_id                 | integer   | null: false                      |
| condition_id                | integer   | null: false                      |
| fee_burden_id               | integer   | null: false                      |
| origin_area_id              | integer   | null: false                      |
| days_until_shipping_id      | integer   | null: false                      |
| price                       | integer   | null: false                      |
| users                       | references| null: false, foreign_key: true   |

### Association
- belongs_to :users
- has_one    :purchase

Buyers(配送先情報)

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| users   | references | null: false, foreign_key: true |
| items   | references | null: false, foreign_key: true 

### Association
- belongs_to :users
- belongs_to :items
- has_one    :address

Addresses（配送先住所）

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| postal_code    | string     | null: false                    |
| origin_area_id | integer    | null: false                    |
| city           | string     | null: false                    |
| address_line   | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| buyers         | references | null: false, foreign_key: true |

### Association
- belongs_to :buyers