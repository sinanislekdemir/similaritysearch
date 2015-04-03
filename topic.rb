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

class Topic
  attr_writer :word_frequency, :language, :topic
  attr_accessor :word_frequency, :language, :topic

  def initialize(topic, language)
    @language = language
    @topic = topic
  end

  def learn(contents)
    words = contents.split(/[\n ,.\[\]]+/).map { |word| word.downcase }
    @word_frequency = Hash[words.group_by {|x| x}.map {|k,v| [k,v.count]}]
    @word_frequency.each do |k, v|
      @word_frequency[k] = v / words.count.to_f
    end
    @word_frequency = Hash[@word_frequency.sort_by{|k, v| v}.reverse]
  end

  def statistics
    contents = "Word Frequency:\n"
    contents += JSON.pretty_generate(@word_frequency)
    File.write('stats/' + @topic + '_' + @language + '.topic', contents)
  end
end
