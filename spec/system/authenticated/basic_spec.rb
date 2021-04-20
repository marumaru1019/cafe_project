require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:time_table) { create(:time_table) }
  let(:event) { create(:event, time_id: time_table.id) }
  let(:event_3in) { create(:event, time_id: time_table.id, date: Time.zone.today + 1, max_num: 10) }
  let(:event_3out) { create(:event, time_id: time_table.id, date: Time.zone.today + 5, max_num: 10) }
  let(:event_out) { create(:event, time_id: time_table.id, date: Time.zone.today - 3, max_num: 10) }
  let(:event_max_1) { create(:event, time_id: time_table.id, max_num: 1) }

  before do
    # 開始3日以内, 開始3日以前, 終了済みの3パターンで分類
    visit user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      before do
        visit root_path
      end

      it 'ヘッダーロゴのルーティング' do
        # expect(page).to have_content '間違っています'
        logo = find_by_id('header-logo')
        logo.click
        expect(subject).to eq '/'
      end

      it 'マイページがあるか？' do
        expect(page).to have_content 'マイページ'
      end

      it '代表者挨拶のルーティング' do
        click_on '代表者挨拶'
        expect(subject).to eq '/events/greeting'
      end

      it 'マイページのルーティング' do
        click_on 'マイページ'
        expect(subject).to eq '/users/' + user.id.to_s
      end

      it 'ヘッダーに新規登録とログインがないことを確認する' do
        expect(page).to have_no_xpath '//a[contains(text(), "新規登録")]'
      end
    end
  end

end
