require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:user_not_confirmed) { create(:user) }
  let(:event) { create(:event) }
  let(:event_join) { create(:event_join) }

  describe 'ログインテスト' do
    before do
      visit new_user_session_path
    end

    context 'ログイン後のルーティング' do
      it 'URLが正しい' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_current_path(root_path)
      end

      it 'ログイン後のメッセージが適切に表示される' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインに成功しました！'
      end
    end

    context 'ログインのエラー' do
      it 'emailかパスワードが間違っている' do
        fill_in 'user[email]', with: user.email + 'miss'
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'アカウントが見つかりません'
      end

      it 'emailはあっているがパスワードが間違っている' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: '11111111'
        click_button 'ログイン'
        expect(page).to have_content '間違っています'
      end
    end
  end
end
