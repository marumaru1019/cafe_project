require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:time_table) { create(:time_table) }
  let(:event) { create(:event, time_id: time_table.id) }

  before do
    visit user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ログイン後のテスト' do
    context 'ログアウトのテスト' do

      it 'URLが正しい' do
        expect(page).to have_current_path(root_path)
      end

      it 'ログアウト成功のメッセージが表示される' do
        find(:xpath, '//a[contains(text(), "ログアウト")]').click
        expect(page).to have_content 'ログアウトに成功しました！'
      end

    end
  end

end
