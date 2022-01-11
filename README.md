

## usersテーブル

| Column                 | Type       | Options                        |
| -----------------------| -----------| -------------------------------|
| nickname               | string     | null: false                    |
| email                  | string     | null: false, unique: true      |
| encrypted_password     | string     | null: false                    |
| first_name_full_width  | string     | null: false                    |
| last_name_full_width   | string     | null: false                    |
| first_name_kana        | string     | null: false                    |
| last_name_kana         | string     | null: false                    |
| date_of_birth          | date       | null: false                    |


### Association
has_many :items
has_many :purchases_records







## itemsテーブル

| Column           | Type       | Options                        |
| -----------------| -----------| -------------------------------|
| title               | string     | null: false                    |
| explanation         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| status_id           | integer    | null: false                    |
| delivery_charge_id  | integer    | null: false                    |
| shipping_area_id    | integer    | null: false                    |
| days_to_ship_id     | integer    | null: false                    |
| price               | integer    | null: false                    |


### Association
belongs_to :user
has_one :purchases_record 







## purchases_recordsテーブル

| Column           | Type       | Options           |
| -----------------| -----------| ------------------|
| user             | references | foreign_key: true |
| item             | references | foreign_key: true |

### Association
has_one :shipping_address
belongs_to :user
belongs_to :item








## shipping_addressesテーブル

| Column            | Type       | Options                        |
| ------------------| -----------| -------------------------------|
| post_code         | string     | null: false                    |
| shipping_area_id  | integer    | null: false                    |
| municipalities    | string     | null: false                    |
| address           | string     | null: false                    |
| building_name     | string     |                                |
| telephone_number  | string     | null: false                    |
| purchases_record  | references | foreign_key: true              |



### Association
belongs_to :purchases_record