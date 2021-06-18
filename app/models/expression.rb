class Expression < ActiveHash::Base
  self.data = [
    { id: 0,  status: '---' },
    { id: 1,  status: '最高' },
    { id: 2,  status: '普通' },
    { id: 3,  status: '最低' },
  ]

  include ActiveHash::Associations
  has_many :records
end