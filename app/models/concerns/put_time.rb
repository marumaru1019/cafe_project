module PutTime
    #以下extendは必須
    extend ActiveSupport::Concern

    def print_day(day)
        require "date"
        return day.strftime('%m').to_i.to_s, day.strftime('%d').to_i.to_s
    end

    def time_part
        {
            today: Time.current.at_beginning_of_day,
            week:  (Time.current.at_beginning_of_day + 6.days).at_end_of_day,
            month: (Time.current.at_beginning_of_day + 1.month).at_end_of_day,
            year: (Time.current.at_beginning_of_day + 1.year).at_end_of_day
        }
    end

    def in_week(item)
        from  = Time.current.at_beginning_of_day
        to    = (from + 6.days).at_end_of_day
        items = item.where(date: from...to)
        return items
    end

    def in_month(item)
        from  = Time.current.at_beginning_of_day
        to    = (from + 1.month)
        items = item.where(date: from...to)
        return items
    end

    def in_year(item)
        from  = Time.current.at_beginning_of_day
        from  = (to - 1.year)
        items = item.where(date: from...to)
        return items
    end


end