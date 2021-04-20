require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  # 認証を行っていないuserを設定 not confirmed_at
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  describe '認証していないユーザーのテスト' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      before do
        visit user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ヘッダーロゴのルーティング' do
        # expect(page).to have_content '間違っています'
        logo = find_by_id('header-logo')
        logo.click
        expect(subject).to eq '/'
      end

      it 'マイページがないか？' do
        expect(page).to have_no_content 'マイページ'
      end

      it 'ログインしてないのにイベントに参加できないことの確認' do
        visit event_path(event)
        expect(page).to have_content 'ログインして参加する'
      end
    end
  end

end
