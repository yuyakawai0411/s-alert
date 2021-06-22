class PhoneCall < ActiveHash::Base
  self.data = [
    { id: 0,  status: '---' },
    { id: 1,  status: 'あり' },
    { id: 2,  status: 'なし' },
  ]

  include ActiveHash::Associations
  has_many :records
end