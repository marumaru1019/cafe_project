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
require 'rails_helper'

# TIPS: モデル.errors.messages[:base]でエラーメッセージ全体を表示
# TIPS: モデル.errors[:カラム]でmodelのデフォルトのエラーを呼び出せる

RSpec.describe User, type: :model do
  describe "名前のバリデーション" do
    context "名前が正しく入力されている" do
      let!(:user) { build(:user, name: "佐々木") }
      it "バリデーション成功" do
        user.valid?
        expect(user).to be_valid
      end
    end

    context "名前が空白" do
      let!(:user) { build(:user, name: nil) }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:name]).to eq ["を入力してください"]
      end
    end
  end

  describe "メールアドレスのバリデーション" do
    context "メールアドレスが正しく入力されている" do
      let!(:user) { build(:user, email: "sample@gmail.com") }
      it "バリデーション成功" do
        user.valid?
        expect(user).to be_valid
      end
    end

    context "メールアドレスが空白" do
      let!(:user) { build(:user, email: nil) }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:email]).to  include("を入力してください")
      end
    end

    context "メールアドレスに@マークがない" do
      let!(:user) { build(:user, email: "smaple.gmail.com") }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:email]).to  include("が正しくありません")
      end
    end

    context "メールアドレスに@マーク以降がない" do
      let!(:user) { build(:user, email: "smaple@") }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:email]).to  include("が正しくありません")
      end
    end

    context "メールアドレスに@マーク以降が1ブロックしかない" do
      let!(:user) { build(:user, email: "smaple@gmail") }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:email]).to  include("が正しくありません")
      end
    end

    context "メールアドレスに@マーク以前がない" do
      let!(:user) { build(:user, email: "@gmail.com") }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:email]).to  include("が正しくありません")
      end
    end
  end

  describe "パスワードのバリデーション" do
    context "パスワードが正しく入力されている" do
      let!(:user) { build(:user, password: "password", password_confirmation: "password") }
      it "バリデーション成功" do
        user.valid?
        expect(user).to be_valid
      end
    end

    context "パスワードが6文字以下" do
      let!(:user) { build(:user, password: "pass", password_confirmation: "pass") }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end

  describe "大学のバリデーション" do
    context "大学が正しく入力されている" do
      let!(:user) { build(:user, university: "早稲田大学") }
      it "バリデーション成功" do
        user.valid?
        expect(user).to be_valid
      end
    end

    context "大学が空白" do
      let!(:user) { build(:user, university: nil) }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors.messages[:base]).to eq ["大学情報を教えて下さい"]
      end
    end
  end

  describe "学年のバリデーション" do
    context "学年が正しく入力されている" do
      let!(:user) { build(:user, grade: 1) }
      it "バリデーション成功" do
        user.valid?
        expect(user).to be_valid
      end
    end

    context "学年がオーバーしてる" do
      let!(:user) { build(:user, grade: 7) }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors.messages[:base]).to eq ["正しい学年を入力してください"]
      end
    end

    context "学年が下回っている" do
      let!(:user) { build(:user, grade: -1) }
      it "バリデーション失敗" do
        user.valid?
        expect(user.errors.messages[:base]).to eq ["正しい学年を入力してください"]
      end
    end
  end
end
