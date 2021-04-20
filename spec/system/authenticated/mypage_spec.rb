require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:time_table) { create(:time_table) }
  let(:event) { create(:event, time_id: time_table.id,  date: Time.zone.today + 20, max_num: 10) }

  before do
    visit user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'マイページのテスト' do

    before do
      visit user_path(user)
    end

    it 'URLが正しい' do
      expect(page).to have_current_path('/users/' + user.id.to_s)
    end

    it '基本情報が表示される' do
      expect(page).to have_content user.name
      expect(page).to have_content user.university
      expect(page).to have_content user.display_grade
    end

    it '参加予定のイベントがないことを確認する' do
      expect(page).to have_content '参加予定のイベントはありません'
    end

    it 'ログアウト成功のメッセージが表示される' do
      find(:xpath, '//a[contains(text(), "ログアウト")]').click
      expect(page).to have_content 'ログアウトに成功しました！'
    end

  end

  describe 'イベントに参加表明をした後のテスト' do
    before do
      visit event_path(event)
      click_on '参加する'
      visit user_path(user)
    end

    it '参加予定のイベントが表示されている' do
      expect(page).to have_content event.name
    end

    it '表示されているイベントからイベント詳細ページに飛べる' do
      click_on event.name
      expect(page).to have_current_path(event_path(event))
    end

  end

end
