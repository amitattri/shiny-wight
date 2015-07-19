module ApplicationHelper
  def resource_name
    :user
  end

  def get_packages(size)
    size = size+1
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def qr_code(size, int)
    "https://chart.googleapis.com/chart?cht=qr&chs=#{size}x#{size}&chl=#{int}"
  end

  def get_address1(address)
    (address.split(';', 2))[0]
  end

  def get_address2(address)
    (address.split(';', 2))[1]
  end

  def user_of(shipment)
    User.find(shipment.user_id)
  end

  def client_of(shipment)
    Address.find(shipment.client)
  end

  def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end

end
