class GamesController < ApplicationController
    require 'open-uri'
    require 'json'

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @valid = valid_word?(@word, @letters)

    if @valid
      @message = "Congratulations! #{@word} is a valid English word!"
    else
      @message = "Sorry but #{@word} can't be built out of #{@letters.join(', ')}"
    end
  end

  private

  def valid_word?(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char) } && english_word?(word)
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']
  end
end
