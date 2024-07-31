# -*- coding: utf-8 -*-
require "colorize"
require 'command_line/global'

$dir = Dir.pwd
$base_name = File.basename($dir).split('_')[1..-1].join('_')

namespace :al_twist do
  desc "puts hyper_card source dir"
  task :hc_source_dir do
    puts "/Users/bob/git_hub/hyper_card/docs/ruby_basic"
  end


  desc "make [default|ARGV[1]].org file" #desc -> description
  task :mk_org do # any name on task_name
    p file = ARGV[1] || $base_name
    text =<<"EOS"
#+OPTIONS: ^:{}
#+STARTUP: indent nolineimages overview num
#+TITLE: #{file}
#+AUTHOR: Shigeto R. Nishitani
#+EMAIL:     (concat "shigeto_nishitani@mac.com")
#+LANGUAGE:  jp
#+OPTIONS:   H:4 toc:t num:2
#+SETUPFILE: https://fniessen.github.io/org-html-themes/org/theme-readtheorg.setup
EOS
    File.write(file+".org", text)
  end

  desc "rename" #desc -> description
  task :rename do # any name on task_name
    Dir.glob("*.jpg").each do |file|
      target = [$target_lecture,"memo",file.split("_")[-1]].join("_")
      FileUtils.mv(file, target, verbose: true)
    end
  end

  desc "mk_list \'*.jpg\' \'with_name\'"
  task :mk_list do # any name on task_name
    p images = if ARGV[1]==nil
                 File.join("./", $base_name, "*")
               else
                 "*.jpg"
               end
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

end
