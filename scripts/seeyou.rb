#!/usr/bin/env ruby

# SEE YOU SPACE COWBOY by DANIEL REHN (danielrehn.com)
# Displays a timeless message in your terminal with cosmic color effects

# Usage: add `ruby ~/seeyouspacecowboy.rb; sleep 2` to .bash_logout (or similar) in your home directory
# (adjust the sleep variable to display the message for more seconds)

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
end

puts '  .d8888b.  8888888888 8888888888      Y88b   d88P  .d88888b.  888     888 '.colorize '38;5;160;01'
puts ' d88P  Y88b 888        888              Y88b d88P  d88P" "Y88b 888     888 '.colorize '38;5;196;01'
puts '  "Y888b.   8888888    8888888            Y888P    888     888 888     888 '.colorize '38;5;202;01'
puts '     "Y88b. 888        888                 888     888     888 888     888 '.colorize '38;5;208;01'
puts '       "888 888        888                 888     888     888 888     888 '.colorize '38;5;214;01'
puts ' Y88b  d88P 888        888                 888     Y88b. .d88P Y88b. .d88P '.colorize '38;5;220;01'
puts '  "Y8888P"  8888888888 8888888888          888      "Y88888P"   "Y88888P"  '.colorize '38;5;226;01'
puts '  .d8888b.  8888888b.     d8888  .d8888b.  8888888888                      '.colorize '38;5;190;01'
puts ' d88P  Y88b 888   Y88b   d88888 d88P  Y88b 888                             '.colorize '38;5;154;01'
puts '  "Y888b.   888   d88P d88P 888 888        8888888                         '.colorize '38;5;118;01'
puts '     "Y88b. 8888888P" d88P  888 888        888                             '.colorize '38;5;046;01'
puts '       "888 888      d88P   888 888    888 888                             '.colorize '38;5;047;01'
puts ' Y88b  d88P 888     d8888888888 Y88b  d88P 888                             '.colorize '38;5;048;01'
puts '  "Y8888P"  888    d88P     888  "Y8888P"  8888888888                      '.colorize '38;5;049;01'
puts '  .d8888b.   .d88888b.  888       888 888888b.    .d88888b. Y88b   d88P    '.colorize '38;5;051;01'
puts ' d88P  Y88b d88P" "Y88b 888   o   888 888  "88b  d88P" "Y88b Y88b d88P     '.colorize '38;5;039;01'
puts ' 888        888     888 888 d888b 888 8888888K.  888     888   Y888P       '.colorize '38;5;027;01'
puts ' 888        888     888 888d88888b888 888  "Y88b 888     888    888        '.colorize '38;5;021;01'
puts ' 888    888 888     888 88888P Y88888 888    888 888     888    888        '.colorize '38;5;021;01'
puts ' Y88b  d88P Y88b. .d88P 8888P   Y8888 888   d88P Y88b. .d88P    888        '.colorize '38;5;057;01'
puts '  "Y8888P"   "Y88888P"  888P     Y888 8888888P"   "Y88888P"     888        '.colorize '38;5;093;01'
