require 'scanf'
require 'pp'

# Current_state
#    key =>  Trans_state, action
TRANSITIONS = {
  head_search: {
    '**'     => [:val_search, :head],
    :default => [:head_search, :idle]
  },
  val_search: {
    '- '     => [:val_search, :get_val],
    :default => [:head_search, :idle]
  }
}

state = :head_search
file = 'README_sample.org'
all_data = []
File.readlines(file).each_with_index do |line,i|
  state, action = TRANSITIONS[state][line[0..1]] ||
                  TRANSITIONS[state][:default]
  case action
  when :head
    p head = line.scanf("** %s")[0] # "** head1\n"
    all_data << [head]
  when :get_val
    p tmp = line.scanf("- %s: %d")
    all_data[-1] << tmp
  when :idle      
  end
end

pp all_data
