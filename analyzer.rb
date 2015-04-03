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

class Analyzer
  attr_writer :languages, :topics, :matches
  attr_accessor :languages, :topics, :matches

  def initialize(languages, topics)
    @languages = languages
    @topics = topics
    @matches = {}
  end

  def score(source, control)
    total_score = 1.0
    control.each  do |key, score|
      if source.key? key
        diff = (score - source[key]).abs
        total_score -= diff
      else
        total_score -= score
      end
    end
    total_score
  end

  def test(contents)
    all_chars = contents.split('')
    letter_frequency = Hash[all_chars.group_by {|x| x}.map {|k,v| [k,v.count]}]

    letter_frequency.each do |k, v|
      letter_frequency[k] = v.to_f / all_chars.count.to_f
    end

    words = contents.split(/[\n ,.\[\]]+/).map { |word| word.downcase }

    word_frequency = Hash[words.group_by {|x| x}.map {|k,v| [k,v.count]}]
    word_frequency.each do |k, v|
      word_frequency[k] = v / words.count.to_f
    end
    letter_frequency = Hash[letter_frequency.sort_by{|k, v| v}.reverse]
    word_frequency = Hash[word_frequency.sort_by{|k, v| v}.reverse]

    @matches[:language] = []
    @languages.each do |code, language|
      @matches[:language] << {
        :lang => code,
        :score => score(
          language.letter_frequency, letter_frequency
          )
      }
    end

    @matches[:topic] = []
    @topics.each do |code, topic|
      @matches[:topic] << {
        :topic => code,
        :score => score(
          topic.word_frequency, word_frequency
          )
      }
    end
    @matches[:topic] = @matches[:topic].sort_by { |k| k[:score] }.reverse
    @matches[:language] = @matches[:language].sort_by { |k| k[:score] }.reverse
    @matches
  end

  def statistics
    JSON.pretty_generate @matches
  end
end
