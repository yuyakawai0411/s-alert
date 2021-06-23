today = Date.today

Card.create(s_last_name: "田中", s_first_name: "万次郎", s_last_name_kana: "タナカ", s_first_name_kana: "マンジロウ", s_company: "YHM", s_company_form_id: 1, s_department: "営業部", s_phone_number: 09087654321, s_birth_day: 1980-10-24)
Card.create(s_last_name: "斉藤", s_first_name: "千重郎", s_last_name_kana: "サイトウ", s_first_name_kana: "センジュウロウ", s_company: "毎日電気", s_company_form_id: 2, s_department: "企画部", s_phone_number: 09087654321, s_birth_day: 1975-09-20)
Card.create(s_last_name: "美羽", s_first_name: "栄三郎", s_last_name_kana: "ミワ", s_first_name_kana: "エイサブロウ", s_company: "大正工業", s_company_form_id: 3, s_department: "開発部", s_phone_number: 09087654321, s_birth_day: 1972-02-15)

Record.create(date: today, time_id: 9, expression_id: 3, call_id: 1, card_id: 1)
Record.create(date: today.next_day(4), time_id: 10, expression_id: 1, call_id: 2, card_id: 1 )
Record.create(date: today.next_day(14), time_id: 18, expression_id: -1, call_id: 1, card_id: 1 )
Record.create(date: today.next_day(14), time_id: 17, expression_id: -2, call_id: 1, card_id: 1 ) 
Record.create(date: today.next_day(10), time_id: 19, expression_id: 3, call_id: 1, card_id:1 )
Record.create(date: today.next_day(6), time_id: 15, expression_id: 0, call_id: 1, card_id:1 )
Record.create(date: today.next_day(26), time_id: 15, expression_id: 2, call_id: 2, card_id:1 )
Record.create(date: today.next_day(2), time_id: 14, expression_id: 1, call_id: 1, card_id:1 )
Record.create(date: today.next_day(10), time_id: 18, expression_id: 3, call_id: 1, card_id:1 )
Record.create(date: today.next_day(6), time_id: 18, expression_id: 1, call_id: 2, card_id:1 )
Record.create(date: today.next_day(16), time_id: 15, expression_id: -1, call_id: 1, card_id:1 )
Record.create(date: today.next_day(24), time_id: 12, expression_id: -2, call_id: 1, card_id:1 )
Record.create(date: today.next_day(26), time_id: 11, expression_id: 3, call_id: 1, card_id:1 )
Record.create(date: today.next_day(10), time_id: 9, expression_id: 0, call_id: 2, card_id:1 )
Record.create(date: today.next_day(14), time_id: 17, expression_id: 2, call_id: 1, card_id:1 )
Record.create(date: today.next_day(28), time_id: 19, expression_id: 1, call_id: 1, card_id:1 )

Record.create(date: today, time_id: 9, expression_id: 3, call_id: 1, card_id: 2)
