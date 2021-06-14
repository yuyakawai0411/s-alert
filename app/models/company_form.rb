class CompanyForm < ActiveHash::Base
  self.data = [
    { id: 0,  form: '---' },
    { id: 1,  form: '株式会社' },
    { id: 2,  form: '有限会社' },
    { id: 3,  form: '合同会社' },
    { id: 4,  form: '合資会社' },
    { id: 5,  form: '合名会社' },
  ]

  include ActiveHash::Associations
  has_many :users
  has_many :cards
end