
file = 'tmp.md'
state = :head_search
File.readlines(file)[0..11].each do |line|
  p [state, line]
  state = :block_search if line.match(/# /)
  state = :head_search if line.match(/^```/)
end
