# This is a dotty config file that creats a initial bash_modules file
#
# Copyright (C) 2012, Devin Weaver
# This work is part of my dotfiles project at http://github.com/sukima/dotfiles
# It is licensed under a Creative Commons Attribution 3.0 Unported License.

class DottyRepository < Thor
  include Thor::Actions

  desc "bootstrap", "Bootstrap bash"
  def bootstrap
    loader_code = "source $HOME/.bash_loader"
    ['.bashrc', '.bash_profile'].each do |file|
      path = File.expand_path("~/#{file}")
      if File.exists? path
        content = File.read(path)
        unless content.include? loader_code
          File.open(path, 'w') do |c|
            c.puts loader_code
            c.write content
          end
        end
      else
        File.open(path, 'w') do |c|
          c.puts loader_code
        end
      end
    end
    unless File.exists?(File.expand_path("~/.bash_modules"))
      descriptions = { }
      files = Dir.glob("bash_modules.d/*")
      files.each do |f|
        File.open(f) do |content|
          while (line = content.gets)
            if line.match(/^#/)
              unless line.match(/(^#!|^[#]?\s*$)/)
                descriptions[f] = line.strip
                break
              end
            end
          end
        end
      end
      File.open(File.expand_path("~/.bash_modules"), "w") do |of|
        of.puts <<-EOF
# bash_modules - defines what modules to load into the bash environment
# Generated for the first time by dotty.
# Repository at http://github.com/sukima/dotfiles
#
# Uncomment any of the following modules to load on next shell invocation.
        EOF
        files.each do |f|
          of.puts
          of.puts descriptions[f]
          of.puts "# #{File.basename(f)}"
        end
      end
    end
  end

  desc "implode", "Implode bash modules"
  def implode
    # Do nothing
  end
end
# vim:set sw=2 et ft=ruby:
