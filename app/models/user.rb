# == Schema Information
#
# Table name: users
#
#  id                                            :bigint(8)        not null, primary key
#  email(メールアドレス)                            :string(255)      not null
#  username(ユーザーネーム)                         :string(255)      not null
#  encrypted_password(暗号化パスワード)             :string(255)      not null
#  reset_password_token(リセットパスワードトークン) :string(255)
#  reset_password_sent_at(リセットパスワード送信日) :datetime
#  remember_created_at(リメンバートークン作成日)    :datetime
#  name(ユーザーネーム)                           :string(255)        not null
#  grade(学年)                                  :integer
#  university(大学)                             :string(255)
#  rank(ユーザーランク)                           :boolean
#  confirmed_at                                     :datetime
#  confirmation_sent_at(確認トークン送信日)         :datetime
#  confirmed_token                                     :datetime
#  unconfirmed_email(未確認メールアドレス)          :string(255)
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :user_image
  has_many :event_joins, dependent: :destroy

  def display_grade
    if grade <= 4
      return '学部' + grade.to_s + '年生'
    elsif grade > 4
      return '修士' + (grade - 4).to_s + '年生'
    end
  end

end
