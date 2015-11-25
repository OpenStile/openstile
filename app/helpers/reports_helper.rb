module ReportsHelper

  def shoppers_created_between datetime_start, datetime_end
    id = UserRole.find_by_name(UserRole::SHOPPER).id
    User.where("user_role_id = ? and created_at > ? and created_at < ?", id, datetime_start, datetime_end)
  end

  def new_shoppers_logged_back_in_between datetime_start, datetime_end
    #Note: not entirely accurate if datetime_end not present day
    new_shoppers = shoppers_created_between datetime_start, datetime_end
    new_shoppers.where("sign_in_count > ? " +
                       "and current_sign_in_at > ? " +
                       "and current_sign_in_at < ?", 
                       2, datetime_start, datetime_end)
  end

  def new_shoppers_booked_drop_in_between datetime_start, datetime_end
    new_shoppers = shoppers_created_between datetime_start, datetime_end
    shopper_ids_booked_drop_ins = DropIn.where("created_at > ? and created_at < ?", 
                                                      datetime_start, datetime_end)
                                                      .pluck(:user_id)
    new_shoppers.where(id: shopper_ids_booked_drop_ins)
  end
end
