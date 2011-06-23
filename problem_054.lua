-- problem #54
job_time = os.time()

names = { '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A' }
suits = { 'H', 'C', 'S', 'D' }

function new_hand()
  local hand = {}
  for _, name in pairs(names) do
    hand[name] = { count = 0 }
  end
  for _, suit in pairs(suits) do
    hand[suit] = { count = 0 }
  end
  return hand
end

function read_hand(s, pos)
  local hand = new_hand()
  for i = pos, pos + 3 * 5 - 1, 3 do
    local card = s:sub(i, i + 1)
    local name = s:sub(i, i)
    local suit = s:sub(i + 1, i + 1)

    hand[name].count = hand[name].count + 1
    hand[suit].count = hand[suit].count + 1
    hand[name][suit] = true
    hand[suit][name] = true
  end
  return hand
end

function is_one_of(hand, name)
  return hand.H[name] or hand.C[name] or hand.S[name] or hand.D[name]
end

function get_High_Card(hand, pos)
  --: Highest value card
  for i = pos or #names, 1, -1 do
    if is_one_of(hand, names[i]) then
      return i
    end
  end
end

function get_One_Pair(hand, pair)
  --: Two cards of the same value
  for i = 1, #names do
    if i ~= pair and hand[names[i]].count == 2 then
      return i
    end
  end
  return 0
end

function get_Two_Pairs(hand)
  --: Two different pairs
  local f = get_One_Pair(hand)
  return f + get_One_Pair(hand, f) * #names
end

function get_Three_of_a_Kind(hand)
  --: Three cards of the same value
  for i = 1, #names do
    if hand[names[i]].count == 3 then
      return i
    end
  end
  return 0
end

function get_Straight(hand)
  --: All cards are consecutive values
  for i = 1, #names - 4 do
    if is_one_of(hand, names[i]) and is_one_of(hand, names[i + 1]) and is_one_of(hand, names[i + 2]) and is_one_of(hand, names[i + 3]) and is_one_of(hand, names[i + 4]) then
      return i
    end
  end
  return 0
end

function get_Flush(hand)
  --: All cards of the same suit
  for i = 1, #suits do
    if hand[suits[i]].count == 5 then
      return get_High_Card(hand)
    end
  end
  return 0
end

function get_Full_House(hand)
  --: Three of a kind and a pair
  local t = get_Three_of_a_Kind(hand)
  local p = get_One_Pair(hand)
  return (t > 0 and p > 0) and t * #names + p or 0
end

function get_Four_of_a_Kind(hand)
  --: Four cards of the same value
  for i = 1, #names do
    if hand[names[i]].count == 4 then
      return i
    end
  end
  return 0
end

function get_Straight_Flush(hand)
  --: All cards are consecutive values of same suit
  for s = 1, #suits do
    local h = hand[suits[s]]
    if h.count == 5 then
      for i = 1, #names - 4 do
        if h[names[i]] and h[names[i + 1]] and h[names[i + 2]] and h[names[i + 3]] and h[names[i + 4]] then
          return i
        end
      end
    end
  end
  return 0
end

function get_Royal_Flush(hand)
  --: Ten, Jack, Queen, King, Ace, in same suit.
  local i = get_Straight_Flush(hand)
  return i == #names - 4 and i or 0
end

function get_Tie(hand1, hand2)
  for i = #names, 1, -1 do
    local c = hand1[names[i]].count - hand2[names[i]].count
    if c ~= 0 then
      return c
    end
  end
  return 0
end

count = 0
rules = {
  "get_Royal_Flush",
  "get_Straight_Flush",
  "get_Four_of_a_Kind",
  "get_Full_House",
  "get_Flush",
  "get_Straight",
  "get_Three_of_a_Kind",
  "get_Two_Pairs",
  "get_One_Pair",
  "get_High_Card"
}

for game in assert(io.open(arg[1] or "poker.txt")):lines() do
  print( game )
  local player_1 = read_hand(game, 1)
  local player_2 = read_hand(game, 1 + 3 * 5)

  local x1, x2

  for i = 1, #rules do
    x1, x2 = _G[rules[i]](player_1), _G[rules[i]](player_2)
    if x1 > x2 then
      print(rules[i], "Player #1 - wins!", x1)
      count = count + 1
      break
    elseif x2 > x1 then
      print(rules[i], "Player #2 - wins!", x2)
      break
    end
  end
  if x1 == x2 then
    local t = get_Tie(player_1, player_2)
    if t > 0 then
      print("get_High_Card", "Player #1 - wins!")
      count = count + 1
    elseif t < 0 then
      print("get_High_Card", "Player #2 - wins!")
    else
      print "Tie!"
    end
  end
end

print("problem #54", "Player 1 wins:", count, count == 376)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
