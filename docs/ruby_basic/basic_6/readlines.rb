file = ARGV[0] || 'README.org'

File.readlines(file).each do |line|
  puts line
end
