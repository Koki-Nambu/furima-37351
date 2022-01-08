

## usersテーブル

| Column                 | Type       | Options                        |
| -----------------------| -----------| -------------------------------|
| nickname               | string     | null: false                    |
| email                  | string     | null: false, unique: true      |
| password               | string     | null: false                    |
| first_name_full_width  | string     | null: false                    |
| last_name_full_width   | string     | null: false                    |
| first_name_kana        | string     | null: false                    |
| last_name_kana         | string     | null: false                    |
| date_of_birth          | integer    | null: false                    |
| shipping_address       | references | null: false, foreign_key: true |


### Association
has_many :items
has_many :purchases_records
has_one :shipping_address







## itemsテーブル

| Column           | Type       | Options                        |
| -----------------| -----------| -------------------------------|
| image            | string     | null: false                    |
| title            | string     | null: false                    |
| explanation      | string     | null: false                    |
| category         | string     | null: false                    |
| status           | string     | null: false                    |
| delivery_charge  | string     | null: false                    |
| shipping_area    | string     | null: false                    |
| days_to_ship     | string     | null: false                    |
| price            | integer    | null: false                    |


### Association
belongs_to :user
has_one :purchases_record 







## purchases_recordsテーブル

| Column           | Type       | Options                        |
| -----------------| -----------| -------------------------------|
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |
| shipping_address | references | null: false, foreign_key: true |

### Association
has_one :shipping_address
belongs_to :user
belongs_to :item








## shipping_addressesテーブル

| Column            | Type       | Options                        |
| ------------------| -----------| -------------------------------|
| post_code         | string     | null: false                    |
| prefectures       | string     | null: false                    |
| municipalities    | string     | null: false                    |
| address           | string     | null: false                    |
| building_name     | string     | null: false                    |
| telephone_number  | integer    | null: false                    |
| user              | references | null: false                    |



### Association
belongs_to :user
belongs_to :purchases_record