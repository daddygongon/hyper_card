require 'scanf'
files = ARGV[0] || "./*.o*"

TRANS = {
  wait_next: {
    '* fix ' => [:searching , :xy_data],
    :default => [:wait_next, :idle]
  },
  searching: {
    '   1 F' => [:wait_next, :z_data],
    :default => [:searching, :idle]
  }
}

state = :wait_next

all_data = []
Dir.glob(files).each do |file|
  File.readlines(file).each do |line|
    state, action = TRANS[state][line[0..5]] ||
                    TRANS[state][:default]
    case action
    when :idle
    when :xy_data
      all_data << line.scanf(
        "* fix calc kpoints:50, in_plane:%f, vertical:%f")
    when :z_data
      all_data[-1] << line.scanf("1 F= %f E0= %f  d E =%f")[0]
    end
  end
end

all_data.each do |data|
  puts "[%5.3f, %5.3f, %10.5f]," % data
end
