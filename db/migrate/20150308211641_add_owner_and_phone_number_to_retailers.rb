class AddOwnerAndPhoneNumberToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers, :owner_name, :string
    add_column :retailers, :phone_number, :string

    Retailer.reset_column_information
    Retailer.update_all(owner_name: 'Owner')
    Retailer.update_all(phone_number: '555-555-5555')

    unless Retailer.find_by_name('Junction').nil?
      Retailer.find_by_name('Junction').update_attribute(:owner_name, 'Shannan')
      Retailer.find_by_name('Junction').update_attribute(:phone_number, '202-483-0261')
    end

    unless Retailer.find_by_name('Violet Boutique').nil?
      Retailer.find_by_name('Violet Boutique').update_attribute(:owner_name, 'Julie')
      Retailer.find_by_name('Violet Boutique').update_attribute(:phone_number, '202-621-9225')
    end

    unless Retailer.find_by_name('Willow').nil?
      Retailer.find_by_name('Willow').update_attribute(:owner_name, 'Julie')
      Retailer.find_by_name('Willow').update_attribute(:phone_number, '202-643-2323')
    end

    unless Retailer.find_by_name('Caramel').nil?
      Retailer.find_by_name('Caramel').update_attribute(:owner_name, 'Sarah')
      Retailer.find_by_name('Caramel').update_attribute(:phone_number, '202-265-1930')
    end

    unless Retailer.find_by_name('LiLi The First').nil?
      Retailer.find_by_name('LiLi The First').update_attribute(:owner_name, 'Ifat')
      Retailer.find_by_name('LiLi The First').update_attribute(:phone_number, '703-261-6323')
    end
  end
end
