## OYSTERCARD CHALLENGE

#### PRY example

```
Adams-MBP:oyster_card adamsnow$ pry
[1] pry(main)> load './lib/oyster_card.rb'
=> true
[2] pry(main)> card = Oystercard.new(10)
=> #<Oystercard:0x007faeb69e1a08 @balance=10, @journeys=[]>
[3] pry(main)> card.top_up(20)
=> 30
[4] pry(main)> card.top_up(61)
RuntimeError: You cannot have more than £90 on your card
from /Users/adamsnow/OneDrive/MacBook Only/Coding/Projects/oyster_card/lib/oyster_card.rb:16:in `top_up'
[5] pry(main)> card
=> #<Oystercard:0x007faeb69e1a08 @balance=30, @journeys=[]>
[6] pry(main)> monument = Station.new('Monument',1)
=> #<Station:0x007faeb62597e0 @name="Monument", @zone=1>
[7] pry(main)> leyton = Station.new('Leyton',3)
=> #<Station:0x007faeb61f2090 @name="Leyton", @zone=3>
[8] pry(main)> card.touch_in(leyton)
=> #<Station:0x007faeb61f2090 @name="Leyton", @zone=3>
[9] pry(main)> card.touch_out(monument)
=> nil
[10] pry(main)> card.journeys
=> [{:time=>2017-04-18 19:12:47 +0100,
  :entry=>#<Station:0x007faeb61f2090 @name="Leyton", @zone=3>,
  :exit=>#<Station:0x007faeb62597e0 @name="Monument", @zone=1>,
  :charge=>1}]
[11] pry(main)> card.balance
=> 29
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
