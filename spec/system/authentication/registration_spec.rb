require 'rails_helper'

describe '新規登録のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:event) { create(:event) }
  let(:event_join) { create(:event_join) }

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(page).to have_current_path('/users/sign_up')
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'universityフォームが表示される' do
        expect(page).to have_field 'user[university]'
      end
      it '登録ボタンが表示される' do
        expect(page).to have_field 'user[grade]'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        fill_in 'user[university]', with: '東北大学'
        select '1年生', from: '学年'
      end

      it '正しく新規登録される' do
        expect { click_button '登録' }.to change(User.all, :count).by(1)
      end
    end

    context '新規登録成功のテスト' do
      $email = Faker::Internet.email
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: $email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        fill_in 'user[university]', with: '東北大学'
        select '1年生', from: '学年'
        click_button '登録'
      end

      it 'リダイレクト先のページに仮登録完了の表示があるか？' do
        expect(page).to have_content '仮登録が完了しました！'
      end

      it 'リダイレクト先のページにメールアドレスが表示されているか？' do
        expect(page).to have_content $email
      end

      it 'リダイレクト先のホーム画面に戻るからルートパスに戻れるか？' do
        find(:xpath, '//a[contains(text(), "ホーム画面へ戻る")]').click
        expect(page).to have_current_path(root_path)
      end
    end

    context '新規登録失敗のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'pass'
        fill_in 'user[password_confirmation]', with: 'missw'
        fill_in 'user[university]', with: 'マサチューセッツ工科大学'
        select '1年生', from: '学年'
      end

      it 'エラーメッセージが全てが表示されるか？' do
        fill_in 'user[password]', with: 'passwor'
        click_button '登録'
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '登録'
        expect(page).to have_content '一致しません'
        expect(page).to have_content '6文字以上'
        expect(page).to have_content '存在します'
      end
    end

    context '新規登録が全て空のテスト' do
      before do
        fill_in 'user[name]', with: nil
        fill_in 'user[email]', with: nil
        fill_in 'user[password]', with: nil
        fill_in 'user[password_confirmation]', with: nil
        fill_in 'user[university]', with: nil
        select '1年生', from: '学年'
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '登録'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワードを入力してください'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'メールアドレスが正しくありません'
        expect(page).to have_content '大学情報を教えて下さい'
      end
    end

    context '新規登録のメールアドレスの形式とパスワードが一致しないテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: "dd@dd"
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'passwords'
        fill_in 'user[university]', with: 'マサチューセッツ工科大学'
        select '1年生', from: '学年'
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '登録'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
        expect(page).to have_content 'メールアドレスが正しくありません'
      end
    end
  end
end
