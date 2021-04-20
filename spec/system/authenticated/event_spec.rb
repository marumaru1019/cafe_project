require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user, confirmed_at: 1.hour.ago) }
  let(:time_table) { TimeTable.first }
  let(:event) { create(:event, time_id: time_table.id) }
  let(:event_3in) { create(:event, time_id: time_table.id, date: Time.zone.today + 1, max_num: 10) }
  let(:event_3out) { create(:event, time_id: time_table.id, date: Time.zone.today + 5, max_num: 10) }
  let(:event_out) { create(:event, time_id: time_table.id, date: Time.zone.today - 3, max_num: 10) }
  let(:event_max_0) { create(:event, time_id: time_table.id, max_num: 0, date: Time.zone.today + 20) }

  before do
    # 開始3日以内, 開始3日以前, 終了済みの3パターンで分類
    visit user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'イベント一覧画面のテスト' do
    before do
      create(:event, time_id: time_table.id, name: "sample1")
      visit events_path
    end

    context '表示内容の確認' do

      it 'URLが正しい' do
        expect(page).to have_current_path('/events')
      end

      it '「イベント一覧」と表示される' do
        expect(page).to have_content 'イベント一覧'
      end

      it 'イベントの名前が表示される' do
        expect(page).to have_content "sample1"
      end

      it 'イベントの名前をクリックして詳細画面に飛べる' do
        click_on 'sample1'
          expect(page).to have_content "sample1"
      end

    end
  end

    # TODO: 開催済みとかが時間によって入れ替わってErrorになる
    # describe '1週間以内のイベント' do

  #     before do
  #         create(:event, time_id: time_table.id, name: "sample2",date: Time.zone.today+1 )         #0: 一週間以内
  #         create(:event, time_id: time_table.id, name: "sample3",date: Time.zone.today+10 )        #1: 一週間以上後
  #         create(:event, time_id: time_table.id, name: "sample4",date: Time.zone.today-1 )         #2: 経過後
  #         visit events_path
  #     end

  #     context '表示内容の確認' do
  #         it '一週間以内のイベントであることが表示されている' do
  #             whithin7Day = all(".event-all__menu__item__content")[0]
  #             expect(whithin7Day).to have_content "開催済み"
  #         end
  #         it 'イベントの名前をクリックして詳細画面に飛べる' do
  #             click_on 'sample2'
  #             expect(page).to have_content "sample2"
  #         end
  #         it '一週間以内のイベントであることが表示されている' do
  #             afterEvent = all(".event-all__menu__item__content")[1]
  #             expect(afterEvent).to have_content "1週間以内のイベント！！"
  #         end
  #         it '一週間以内のイベントであることが表示されている' do
  #             more7Day = all(".event-all__menu__item__content")[2]
  #             expect(more7Day).to have_no_content "1週間以内のイベント！！"
  #             expect(more7Day).to have_no_content "開催済み"
  #         end
  #     end
  # end

  describe '3日以内のイベントのテスト' do
    before do
      visit event_path(event_3in)
    end

    context '3日以内のイベントのテスト' do

      it 'URLが正しい' do
        expect(page).to have_current_path('/events/' + event_3in.id.to_s)
      end

      it '参加可能の表示がされる' do
        expect(page).to have_content "参加可能"
      end

      it '参加するボタンを押すと参加人数が増える' do
        click_on '参加する'
        expect(page).to have_content "1/"
      end

      it '一度参加ボタンを押すとキャンセル不可にできる' do
        click_on '参加する'
        expect(page).to have_content "キャンセル不可"
      end

      it 'キャンセル不可のときのメッセージが正しく表示される' do
        click_on '参加する'
        expect(page).to have_content "既にキャンセル期間が過ぎているイベントです。"
      end

    end
  end

  describe '3日以上空いているときのテスト' do
    before do
      visit event_path(event_3out)
    end

    context '3日以上空いているときのテスト' do
      it 'URLが正しい' do
        expect(page).to have_current_path('/events/' + event_3out.id.to_s)
      end

      it '参加可能の表示がされる' do
        expect(page).to have_content "参加可能"
      end

      it '参加するボタンを押すと参加人数が増える' do
        click_on '参加する'
        expect(page).to have_content "1/"
      end

      it '参加すると参加取り消しボタンに変更できる' do
        click_on '参加する'
        expect(page).to have_content "参加取り消し"
      end

    end
  end

  describe '終了済みのイベントのテスト' do
    before do
      visit event_path(event_out)
    end

    context '終了済みのイベントのテスト' do

      it 'URLが正しい' do
        expect(page).to have_current_path('/events/' + event_out.id.to_s)
      end

      it '終了済みボタンが表示される' do
        expect(page).to have_content "終了済み"
      end

      it 'cssを変更して終了済みを押されてもroot_pathに飛ばされる' do
        click_on '終了済み'
        expect(page).to have_current_path(root_path)
      end

    end
  end

  describe '参加人数上限のテスト' do
    before do
      visit event_path(event_max_0)
    end

    context '参加人数上限のテスト' do

      it 'URLが正しい' do
        expect(page).to have_current_path('/events/' + event_max_0.id.to_s)
      end

      it '参加人数上限のラベルが表示される' do
        expect(page).to have_xpath '//span[contains(text(), "参加不可")]'
      end

      it '参加人数上限ボタンが表示される' do
        expect(page).to have_xpath '//a[contains(text(), "参加不可")]'
      end

      it 'cssを変更して終了済みを押されてもroot_pathに飛ばされる' do
        click_on '参加不可'
        expect(page).to have_current_path(root_path)
      end

    end
  end

end
