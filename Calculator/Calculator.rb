#!/usr/bin/ruby

require './Expression.rb'

class Calculator
    def initialize()
        @expression = Expression.new(ARGV[0])
        puts @expression.GetAnswer
    end

end

calculator = Calculator.new