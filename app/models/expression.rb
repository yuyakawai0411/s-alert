class Expression < ActiveHash::Base
  self.data = [
    { id: 0,  status: '---' },
    { id: 1,  status: '良い' },
    { id: 2,  status: 'かなり良い' },
    { id: 3,  status: 'めっちゃ良い' },
    { id: -1,  status: '悪い' },
    { id: -2,  status: 'かなり悪い' },
    { id: -3,  status: 'めっちゃ悪い' },
  ]

  include ActiveHash::Associations
  has_many :records
end