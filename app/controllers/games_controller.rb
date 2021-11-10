require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...9).map { ('A'..'Z').to_a[rand(9)] }
  end

  def valid_input(attempt, grid)
    check = attempt.chars
    new_array = [].replace(grid)
    check.each do |i|
      if new_array.include? i
        element = new_array.find_index(i)
        new_array[element] = "!"
        # puts new_array
      else
        return false
      end
    end
    return true
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    validity = URI.open(url).read
    valid = JSON.parse(validity)
    if valid['found'] == true
    # puts valid_input(attempt, grid)
      if valid_input(params[:word], @letters) == true
        message_final = "Well done!"
      else
        message_final = "not in the grid"
      end
    else
      message_final = "Not an English word."
    end
    # if valid['found'] == true
    #   message_final = "Well done!"
    # else
    #   message_final = "not in the grid"
    # end
    @message = message_final
  end
end
