class PhoneTime < ActiveHash::Base
  self.data = [
    { id: 0,  time: '---' },
    { id: 7,  time: '7:00' },
    { id: 8,  time: '8:00' },
    { id: 9,  time: '9:00' },
    { id: 10,  time: '10:00' },
    { id: 11,  time: '11:00' },
    { id: 12,  time: '12:00' },
    { id: 13,  time: '13:00' },
    { id: 14,  time: '14:00' },
    { id: 15,  time: '15:00' },
    { id: 16,  time: '16:00' },
    { id: 17,  time: '17:00' },
    { id: 18,  time: '18:00' },
    { id: 19,  time: '19:00' },
    { id: 20,  time: '20:00' },
    { id: 21,  time: '21:00' },
    { id: 22,  time: '22:00' },
  ]

  include ActiveHash::Associations
  has_many :records
end