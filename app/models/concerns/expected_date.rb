module ExpectedDate
  extend ActiveSupport::Concern

    included do
      after_save :calculate_expected_date
    end

    def calculate_expected_date
    	if(self.created_at.beginning_of_day < self.created_at && self.created_at <= self.created_at.beginning_of_day+12.hours)
    		update_column :expected_delivery_date, (self.created_at).to_date
    	else
    		update_column :expected_delivery_date, (self.created_at+1.day).to_date
    	end
        update_column :ship_date, (self.created_at).to_date
    end

end