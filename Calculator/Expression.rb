#!/usr/bin/ruby

class Expression
    def initialize(value)
        @value = value
        self.DeleteSpace
        self.MakeLexemes
        while (self.FindBrackets)
        end
        #self.ShowLexemes
        self.Degree
        self.MultiplicatioAndDivision
        self.PlusAndMinus
    end

    def DeleteSpace
        @value = @value.gsub(" ", "")
        #puts "#{@value}"
    end

    def MakeLexemes
        #0 - wait number, unary operator or open bracket, 1 - wait any operator, or close bracket
        array = @value.chars
        #puts "#{array}"
        @lexemes = []
        state = 0
        tmpValue = ''
        for i in 0...array.length
            if ((array[i].to_i.to_s == array[i]) && ((state == 0) || (state == 1)))
                tmpValue += array[i]
                state = 1
                if (i == array.length - 1)
                    @lexemes.insert(0, tmpValue)
                    break
                end
                next
            end
            if ((array[i].to_i.to_s != array[i]))
                @lexemes.insert(0, tmpValue)
                @lexemes.insert(0, array[i])
                state = 0
                tmpValue = ''
                next
            end
        end
        @lexemes = @lexemes.reverse!
        @lexemes.delete("")
        #puts "#{@lexemes}"
    end

    def Degree
        isEnd = false
        while (!isEnd)
            if (@lexemes.length == 1)
                break
            end
            newLexemes = []
            for i in 0...(@lexemes.length - 2)
                if (@lexemes[i + 1] == "^")
                    value = @lexemes[i].to_i ** @lexemes[i + 2].to_i
                    #puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                    newLexemes.insert(0, value)
                    for j in i + 3...(@lexemes.length)
                        newLexemes.insert(0, @lexemes[j])
                    end
                    @lexemes = newLexemes.reverse!
                    #puts "#{@lexemes}"
                    break
                else
                    newLexemes.insert(0, @lexemes[i])
                    if (i == @lexemes.length - 3)
                        isEnd = true
                    end
                end
            end
        end
    end

    def MultiplicatioAndDivision
        isEnd = false
        while (!isEnd)
            if (@lexemes.length == 1)
                break
            end
            newLexemes = []
            for i in 0...(@lexemes.length - 2)
                if (@lexemes[i + 1] == "*")
                    value = @lexemes[i].to_i * @lexemes[i + 2].to_i
                    #puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                    newLexemes.insert(0, value)
                    for j in i + 3...(@lexemes.length)
                        newLexemes.insert(0, @lexemes[j])
                    end
                    @lexemes = newLexemes.reverse!
                    #puts "#{@lexemes}"
                    break
                else
                    if (@lexemes[i + 1] == "/")
                        value = @lexemes[i].to_i / @lexemes[i + 2].to_i
                        #puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                        newLexemes.insert(0, value)
                        for j in i + 3...(@lexemes.length)
                            newLexemes.insert(0, @lexemes[j])
                        end
                        @lexemes = newLexemes.reverse!
                        #puts "#{@lexemes}"
                        break
                    else
                       newLexemes.insert(0, @lexemes[i])
                       if (i == @lexemes.length - 3)
                           isEnd = true
                       end
                    end
                end
            end
        end
    end

    def PlusAndMinus
        isEnd = false
        while (!isEnd)
            if (@lexemes.length == 1)
                break
            end
            newLexemes = []
            for i in 0...(@lexemes.length - 2)
                if (@lexemes[i + 1] == "+")
                    value = @lexemes[i].to_i + @lexemes[i + 2].to_i
                    #puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                    newLexemes.insert(0, value)
                    for j in i + 3...(@lexemes.length)
                        newLexemes.insert(0, @lexemes[j])
                    end
                    @lexemes = newLexemes.reverse!
                    break
                else
                    if (@lexemes[i + 1] == "-")
                        value = @lexemes[i].to_i - @lexemes[i + 2].to_i
                        newLexemes.insert(0, value)
                        for j in i + 3...(@lexemes.length)
                            newLexemes.insert(0, @lexemes[j])
                        end
                        @lexemes = newLexemes.reverse!
                        #puts "#{@lexemes}"
                        break
                    else
                       newLexemes.insert(0, @lexemes[i])
                       if (i == @lexemes.length - 3)
                           isEnd = true
                       end
                    end
                end
            end
        end
    end

    def FindBrackets
        indexStart = -1
        indexFinish = -1
        countOpenBrackets = 0
        countCloseBrackets = 0
        for i in 0...@lexemes.length
            if (@lexemes[i] == "(")
                if (indexStart == (-1))
                    indexStart = i
                end
                countOpenBrackets += 1
            end
            if (@lexemes[i] == ")")
                countCloseBrackets += 1
                if (countOpenBrackets == countCloseBrackets)
                    indexFinish = i
                    break
                end
            end
        end
        #puts "#{indexStart} #{indexFinish} #{countOpenBrackets} #{countCloseBrackets}"
        if (countOpenBrackets != countCloseBrackets)
            abort "Incorrect number of Brackets"
        end

        if (indexStart != indexFinish)
            newValue = self.GetPath(indexStart + 1, indexFinish).join
            #puts "Brackets values: #{newValue}"
            newExpression = Expression.new(newValue)
            self.ReplacePath(indexStart, indexFinish, newExpression.GetAnswer)
            return true
        end

        return false
    end

    def GetPath(start, finish)
        path = []
        for i in start...finish
            if (i == @lexemes.length)
                break
            end
            path.insert(0, @lexemes[i])
        end
        return path.reverse!
    end

    def ReplacePath(indexStart, indexFinish, value)
        newLexemes = []
        #puts "#{indexStart} #{indexFinish}"
        for i in 0...@lexemes.length
            if (i == indexStart)
                newLexemes.insert(0, value)
            else
                if ((i < indexStart) || (i > indexFinish))
                    newLexemes.insert(0, @lexemes[i])
                end
            end
        end
        @lexemes = newLexemes.reverse!

    end

    def ShowLexemes
        puts "#{@lexemes}"
    end

    def GetAnswer
        return @lexemes[0];
    end
end