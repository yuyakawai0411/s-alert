class PhoneCall < ActiveHash::Base
  self.data = [
    { id: 0,  status: '---' },
    { id: 1,  status: 'ăă' },
    { id: 2,  status: 'ăȘă' },
  ]

  include ActiveHash::Associations
  has_many :records
end