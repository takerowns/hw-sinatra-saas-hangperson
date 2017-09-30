class HangpersonGame
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''

  end

  def guess(letter)
    
    if(letter =~ /[A-Z]/)
      return false
    end
    if (letter == '') || (letter =~ /[^a-z]/) || (letter.nil?)
      raise ArgumentError , "Wrong argument"
    end
    
    if (@guesses.include? letter) || (@wrong_guesses.include? letter)
      return false
    end
    if (@word.include? letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end
  
  def check_win_or_lose
    
    if (!word_with_guesses.include? '-')
      return :win
    elsif(wrong_guesses.length >= 7)
    return :lose
    else
      return :play
    end
  end
  
  def word_with_guesses
    
    word =""
    letters = @word.split('')
    letters.each { |x|
    
      if (guesses.include? x)
        word += x
      else
        word += "-"
      end
    }
    return word
  end
  
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
