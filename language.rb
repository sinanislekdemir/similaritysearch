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

require 'json'

class Language
  attr_writer :letter_frequency, :word_frequency, :code
  attr_accessor :letter_frequency, :word_frequency, :code

  def initialize(code)
    @code = code
    @letter_frequency = {}
    @word_frequency = {}
  end

  def learn(contents)
    all_chars = contents.split('')
    @letter_frequency = Hash[all_chars.group_by {|x| x}.map {|k,v| [k,v.count]}]

    @letter_frequency.each do |k, v|
      @letter_frequency[k] = v.to_f / all_chars.count.to_f
    end

    words = contents.split(/[\n ,.\[\]]+/).map { |word| word.downcase }

    @word_frequency = Hash[words.group_by {|x| x}.map {|k,v| [k,v.count]}]
    @word_frequency.each do |k, v|
      @word_frequency[k] = v / words.count.to_f
    end
    @letter_frequency = Hash[@letter_frequency.sort_by{|k, v| v}.reverse]
    @word_frequency = Hash[@word_frequency.sort_by{|k, v| v}.reverse]
  end

  def statistics
    contents = "Letter Frequency:\n"
    contents += JSON.pretty_generate(@letter_frequency)
    contents += "\nWord Frequency:\n"
    contents += JSON.pretty_generate(@word_frequency)
    File.write('stats/' + @code + '.lang', contents)
  end
end
