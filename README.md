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
| password            | string  | null: false                      |
| last_name           | string  | null: false                      |
| first_name          | string  | null: false                      |
| kana_last_name      | string  | null: false                      |
| kana_first_name     | string  | null: false                      |
| birthday            | date    | null: false                      |


Items（商品情報）

| Column                     | Type       | Options                           |
|-----------------------------|------------|----------------------------------|
| image                       | binary     | null: false                      |
| title                       | string     | null: false                      |
| description                 | text       | null: false                      |
| price                       | integer    | null: false                      |
| category                    | string     | null: false                      |
| condition                   | string     | null: false                      |
| price                       | integer    | null: false                      |
| fee burden                  | string     | null: false                      |
| fee burden                  | string     | null: false                      |
| origin area                 | string     | null: false                      |
| user                        | references | null: false, foreign_key: true   |

Buyer(配送先情報)

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |


Addresses（配送先住所）

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| postal_code    | string     | null: false                    |
| prefecture     | string     | null: false                    |
| city           | string     | null: false                    |
| address_line   | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| purchase       | references | null: false, foreign_key: true |
