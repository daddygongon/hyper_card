# Current_state =>  Trans_state, Key
TRANSITIONS = {
  :head_search => [:val_search, "**"],
  :val_search => [:head_search, "- "]
}
state,key = TRANSITIONS[:head_search]
file = 'README.org'
temp, contents = [], []
File.readlines(file)[10..20].each_with_index do |line,i|
  p [i, 'before', state, key, line]
  state, key = TRANSITIONS[state] if line[0..1] == key
  p [i, 'after ', state, key, line]
  case state
  when :head_search
    contents << temp
    p temp = line.scan(/\*\* (\w+)/)[0] #"** head1\n"
  when :val_search
    temp << line
  end
end

pp contents
