class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
    @track_guessed_letter = Set.new
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)

    if letter == '' || letter == nil || !letter.match?(/[A-Za-z]/)
      raise ArgumentError
    end

    letter_lower = letter.downcase

    if @track_guessed_letter.include? letter_lower
      return false
    else
      @track_guessed_letter.add letter_lower
    end

    if @word.include? letter_lower
      @guesses += letter_lower
    elsif
      @wrong_guesses += letter_lower
    end
    return true
  end

  def word_with_guesses
    word_under_construct = ['-'] * @word.length
    @word.each_char.with_index do |char, index|
      if guesses.include? char
        word_under_construct[index] = char
      end
    end
    return word_under_construct.join
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
