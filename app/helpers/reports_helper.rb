module ReportsHelper

  def shoppers_created_between datetime_start, datetime_end
    Shopper.where("created_at > ? and created_at < ?", datetime_start, datetime_end)
  end
end
