# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  grade                  :integer
#  image                  :string
#  name                   :string           not null
#  rank                   :boolean          default(FALSE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  university             :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :user_image
  has_many :event_joins, dependent: :destroy

  # TIPS: 単数のvalidateの場合は自分で作成したメソッドを使用できる
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password, confirmation: true
  validate  :university_presence
  validate  :is_student


  def display_grade
    if grade <= 4
      '学部' + grade.to_s + '年生'
    elsif grade > 4
      '修士' + (grade - 4).to_s + '年生'
    end
  end

  private

  def university_presence
    return if university.present?
    errors[:base] << "大学情報を教えて下さい"
  end

  def is_student
    return if grade >= 1 && grade <=6
    errors[:base] << "正しい学年を入力してください"
  end

end
