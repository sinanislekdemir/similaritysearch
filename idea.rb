#!/usr/bin/ruby

##############################################################################
#    Similarity Search Script
#    Copyright (C) 2015  Sinan ISLEKDEMIR
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
##############################################################################

##############################################################################
# This script is an example for analysing similar texts and recognizing
# new texts for where they belong
#
# !! IMPORTANT, ALL DATA IS FROM WIKIPEDIA!!
# http://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License
##############################################################################

$LOAD_PATH << './'

require 'colors'
require 'language'
require 'topic'
require 'analyzer'

languages = ['de', 'en', 'fr', 'tr']
topics    = ['computer', 'food', 'history', 'literature', 'medical', 'science']

language_db = {}
topic_db = {}

puts 'Generating language databases'.red.bold
languages.each do |lang|
  language_db[lang] = Language.new(lang)
end

puts 'Generating topic databases'.red.bold
topics.each do |topic|
  languages.each do |lang|
    topic_db[topic + '_' + lang] = Topic.new(topic, lang)
  end
end

puts 'Learning languages...'.bold

languages.each do |lang|
  puts "Learning #{lang}".green.bold
  content = ''
  topics.each do |topic|
    dir = 'data/' + topic + '/' + lang + '/*'
    files = Dir[dir]
    files.each do |file|
      fc = File.read file
      content = content + "\n" + fc
    end
  end
  language_db[lang].learn(content)
  language_db[lang].statistics
end

puts 'Learning topics...'.bold

topics.each do |topic|
  puts "Learning #{topic}".green.bold
  languages.each do |lang|
    content = ''
    dir = 'data/' + topic + '/' + lang + '/*'
    files = Dir[dir]
    files.each do |file|
      fc = File.read file
      content = content + "\n" + fc
    end
    topic_db[topic + '_' + lang].learn(content)
    topic_db[topic + '_' + lang].statistics
  end
end

if ARGV.count == 0
  puts 'Specify filename to analyze..'
  exit 0
end

contents = File.read ARGV[0]
analyzer = Analyzer.new(language_db, topic_db)
analyzer.test contents
puts analyzer.statistics if ARGV.count > 1 && ARGV[1] == 'debug'
puts "------------------------".green.bold
puts "Probable Result".green.bold
puts "------------------------\n".green.bold
puts "Language: ".blue.bold + analyzer.matches[:language][0][:lang].bold
puts "Topic: ".blue.bold + analyzer.matches[:topic][0][:topic].bold

