# -*- coding: utf-8 -*-
require "colorize"
require 'command_line/global'

namespace :comp_a do

  $target_dir = '/Users/bob/Sites/new_ist/CompAInfo/24s/'
  $target_lecture = 'junior_24s'
  $dir = File.join($target_dir,$target_lecture)
  p ['target hiki dir:', $dir]

  desc "rename" #desc -> description
  task :rename do # any name on task_name
    Dir.glob("*.jpg").each do |file|
      target = [$target_lecture,"memo",file.split("_")[-1]].join("_")
      FileUtils.mv(file, target, verbose: true)
    end
  end

  desc "delete private files"
  task :del_num do
    ['01','02','03','04','16','17',
     '23','26','29','30','32','33','36'
    ].each do |num|
      FileUtils.rm "seminar_24s-#{num}.jpg"
    end
  end

  desc "mk_list \'*.jpg\' \'with_name\'"
  task :mk_list do # any name on task_name
    images = ARGV[1] || "*.jpg"
    opt = ARGV[2] || "no_name"
    puts ['ARGV', images, opt]
    Dir.glob(images).each do |file|
      if opt == 'with_name'
        puts "| #{file} | [[file:./#{file}]]"
      else
        puts "| [[file:./#{file}]]"
      end
    end
    exit
  end

  desc "make hyper_card links"
  task :hyper_card do
    [Dir.glob("images/*.jpg"),
     Dir.glob("**/*.html")
    ].flatten.each do |file|
      FileUtils.cp(file,  File.join($dir,file), verbose: true)
    end
    system "chmod -R a+r #{$dir}/*"
    system 'rsync --exclude .git -auvz -e ssh ~/Sites/new_ist/ nishitani@ist.ksc.kwansei.ac.jp:~/public_html'
    system "open https://ist.ksc.kwansei.ac.jp/~nishitani/CompAInfo/24s/#{$target_lecture}/README.html"
  end
end
