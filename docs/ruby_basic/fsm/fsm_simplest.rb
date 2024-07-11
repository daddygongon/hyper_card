require 'scanf'
TRANSITIONS = {
    :head_search => [:block_search, "**"],
    :block_search => [:head_search, "- "]
}
state, key = TRANSITIONS[:head_search]
file = 'README.org'
File.readlines(file)[12..15].each do |line|
  p [state, key, line]
  p result = line[0..1] == key
  state, key = TRANSITIONS[state] if result != []
end
