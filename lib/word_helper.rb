module WordHelper

  class WordCounter
    attr_reader :words
    attr_accessor :word_count

    def self.tally phrase
      new(phrase).tally
    end

    def initialize phrase
      @words = create_words phrase
      @word_count = Hash.new 0
    end

    def tally
      words.each_with_object(word_count) do |word, occurence|
        word_count[word.to_sym] += 1
      end
    end

    private

    def create_words phrase
      phrase.split.map(&:downcase)
    end
  end

  class Blacklist
    attr_reader :phrase, :blacklist, :blacklist_regex

    def self.filter phrase, blacklist
      new(phrase, blacklist).filter
    end

    def initialize phrase, blacklist
      @phrase = phrase
      @blacklist = blacklist
      @blacklist_regex = %r{#{blacklist.tr " ", "|"}}i
    end

    def filter
      phrase.gsub(blacklist_regex) { |match| "*" * match.length }
    end
  end

  class LinkBuilder
    attr_reader :message, :domain, :username_regex

    def self.create message, domain
      new(message, domain).create
    end

    def initialize message, domain
      @message = message
      @domain  = domain
      @username_regex = /@[^\s]+/
    end

    def create
      message.gsub(username_regex) { |username| link_to username }
    end

    private

    def link_to username
      "<a href='#{domain}#{username[1..-1]}'>#{username}</a>"
    end
  end

  module_function

  def tally phrase
    WordCounter.tally phrase
  end

  def filter phrase, blacklist
    Blacklist.filter phrase, blacklist
  end

  def link_to_users message, domain
    LinkBuilder.create message, domain
  end
end
