require 'command_line/global'
require 'colorize'

file = ARGV[0] || 'hc_index.org'

def to_hash(string)
  argvs = {}
  string.split(" ").each_with_index do |word, i|
    case i
    when 0
      argvs[:head] = word
      base=File.basename(word)
      argvs[:base] = base
    else
      tag, val = word.split(":")
      argvs[tag.to_sym] = val
    end
  end
  argvs[:no] = argvs[:no]==nil ? '001' :
                 format("%03d" % argvs[:no])
  argvs[:width] = argvs[:width]==nil ? '500':
                    argvs[:width]
  argvs
end
def to_icon(argv)
  p argvs = to_hash(argv)
  html =<<"EOL"
* #{argvs[:base]}
#+begin_export html
<a href="#{argvs[:head]}.html"
  class="example">
  <img src="#{argvs[:head]}/#{argvs[:base]}.#{argvs[:no]}.png"
  width=#{argvs[:width]}
  alt=#{argvs[:base]}
  >
</a>
#+end_export
EOL
end
output = File.readlines(file).collect do |line|
  if (m = line.match(/^\#\+icon:(.*)/)) != nil
    to_icon(m[1])
  else
    line.chomp
  end
end

t_file = "index.org"
File.write(t_file, output.join("\n"))

com ="emacs #{t_file} --batch -l ~/.emacs.d/init.el -f org-html-export-to-html --kill"
res = command_line(com)
puts res.stdout.green
puts res.stderr.red
