module AdminHelper

  def user_name
    name = "#{current_user.first_name} #{current_user.last_name}"
    return name
  end

  def back_page
    if $page == 'ts'
      admin_today_shipments_path
    elsif $page == 'sh'
      admin_shipment_history_path
    else
      shipments_path
    end
  end
end
