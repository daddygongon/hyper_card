def get_coin(coin, x) # 剰余
  if x>=coin
    y = x/coin
    x = x%coin
    p [coin.to_s, y]
  end
  return x
end

# beta : test駆動, devide and conquer分割統治, 各個撃破
# 古い先生 : `数学の問題を解く`ようにして
# meta : まとまった

p x = (ARGV[0] || '721').to_i # 入力の確認
[10000, 5000, 1000,# 変わるとロコを配列に
 500, 100, 50, 10, # hard coding(500, 100)
 1].each do |coin| # soft
  x= get_coin(coin, x) # 同じ繰り返し動作=> def
end
