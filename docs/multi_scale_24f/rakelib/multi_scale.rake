# -*- coding: utf-8 -*-
require "colorize"
require 'command_line/global'

namespace :multi_scale do

  $target_dir = '/Users/bob/Sites/new_ist/CompAInfo/24f'
  $target_lecture = 'multi_scale_24f'
  $dir = File.join($target_dir,$target_lecture)
  p ['target hiki dir:', $dir]

  desc "istruction for initialize"
  task :init do
    puts "1. mkdir -p #{$dir}".blue
    puts "2. emacs readme.org and export to html".blue
    puts "3. rake multi_scale:hyper_card".blue
    puts "     - this_com makes copies of files, rsync and open ist.".green
  end

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
    [Dir.glob("**/*.jpg"),
     Dir.glob("**/*.html")
    ].flatten.each do |file|
      FileUtils.cp(file,  File.join($dir,file), verbose: true)
    end
    ist_dir = File.join(File.basename($target_dir),
                        'multi_scale_24f')
    system "chmod -R a+r #{$dir}/*"
    system 'rsync --exclude .git -auvz -e ssh ~/Sites/new_ist/ nishitani@ist.ksc.kwansei.ac.jp:~/public_html'
    system "open https://ist.ksc.kwansei.ac.jp/~nishitani/CompAInfo/#{ist_dir}/readme.html"
  end
end
