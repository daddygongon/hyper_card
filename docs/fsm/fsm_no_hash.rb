
file = 'README_sample.org'
state = :head_search
File.readlines(file)[12..15].each do |line|
  p [state, line]
  state = :block_search if line.match(/\*\* /)
  state = :head_search if line.match(/^-/)
end
