require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:event) { create(:event) }
  let(:event_join) { create(:event_join) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    describe 'ヘッダーのテスト: ログインしていない場合' do
      context 'ヘッダーのルーティングの確認' do
        subject { current_path }

        it '新規登録のルーティング' do
          # click_on '新規登録'
          find(:xpath, '//a[contains(text(), "新規登録")]').click
          expect(subject).to eq '/users/sign_up'
        end

        it 'ログインのルーティング' do
          find(:xpath, '//a[contains(text(), "ログイン")]').click
          # click_on 'ログイン'
          expect(subject).to eq '/users/sign_in'
        end

        it 'ヘッダーに新規登録とログインがないことを確認する' do
          expect(page).to have_no_content 'マイページ'
          expect(page).to have_no_content 'ログアウト'
        end
      end
    end
  end

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'ログインボタンからログイン処理ができるか確かめる' do
        find(:xpath, '//a[contains(@class, "event-top__btn login")]').click
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit '/users/' + user.id.to_s
        expect(page).to have_content '参加予定の活動'
      end
    end
  end

end
