## OYSTERCARD CHALLENGE

#### PRY example

```
[1] pry(main)> load './lib/oyster_card.rb'
=> true
[2] pry(main)> card = Oystercard.new
=> #<Oystercard:0x007ffcff376960 @balance=0, @journeys=[]>
[3] pry(main)> card.top_up(20)
=> 20
[4] pry(main)> leyton = Station.new('Leyton',3)
=> #<Station:0x007ffcff2e43d0 @name="Leyton", @zone=3>
[5] pry(main)> bank = Station.new('Bank',1)
=> #<Station:0x007ffcff29d688 @name="Bank", @zone=1>
[6] pry(main)> card.touch_in(leyton)
=> #<Station:0x007ffcff2e43d0 @name="Leyton", @zone=3>
[7] pry(main)> card.touch_out(bank)
=> nil
[8] pry(main)> card
=> #<Oystercard:0x007ffcff376960
 @balance=17,
 @entry_station=nil,
 @journeys=
  [{:time=>2017-04-18 19:47:02 +0100,
    :entry=>#<Station:0x007ffcff2e43d0 @name="Leyton", @zone=3>,
    :exit=>#<Station:0x007ffcff29d688 @name="Bank", @zone=1>,
    :charge=>3}]>
```

#### User stories

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```

#### Functional Representation

Objects  | Messages
------------- | -------------
Oystercard  | Topup
Oystercard  | Deduct
Station  |
Journey | Calculate charge
