#!/usr/bin/ruby

class Expression
    def initialize(value)
        @value = value
        if (value != "")
            self.DeleteSpaces
            self.MakeLexemes
            if (@lexemes.length > 1)
                while (!self.Optimization)
                end
                self.Validate()
                self.CheckUnaryOperators
                while (self.FindBrackets)
                end
                self.Degree
                self.MultiplicatioAndDivision
                self.PlusAndMinus
            end
        else
            abort "Incorrect Expression"
        end
    end

    def DeleteSpaces
        @value = @value.gsub(" ", "")
        if (ARGV[1] == "-i")
            puts "#{@value}"
        end
    end

    def MakeLexemes
        array = @value.chars
        @lexemes = []
        tmpValue = ''
        for i in 0...array.length
            if ((array[i].to_i.to_s == array[i]) || (array[i] == "."))
                tmpValue += array[i]
                if (i == array.length - 1)
                    @lexemes.insert(0, tmpValue)
                    break
                end
                next
            end
            if ((array[i].to_i.to_s != array[i]))
                @lexemes.insert(0, tmpValue)
                @lexemes.insert(0, array[i])
                tmpValue = ''
                next
            end
        end
        @lexemes = @lexemes.reverse!
        @lexemes.delete("")
        if (ARGV[1] == "-i")
            puts "#{@lexemes}"
        end
    end

    def Optimization
        newLexemes = []
        i = 0
        isEnd = true
        while (i < (@lexemes.length - 1))
            if ((@lexemes[i] == "+") && (@lexemes[i + 1] == "+"))
                newLexemes.insert(0, "+")
                i += 2
                isEnd = false
                next
            end
            if ((@lexemes[i] == "+") && (@lexemes[i + 1] == "-"))
                newLexemes.insert(0, "-")
                i += 2
                isEnd = false
                next
            end
            if ((@lexemes[i] == "-") && (@lexemes[i + 1] == "+"))
                newLexemes.insert(0, "-")
                i += 2
                isEnd = false
                next
            end
            if ((@lexemes[i] == "-") && (@lexemes[i + 1] == "-"))
                newLexemes.insert(0, "+")
                i += 2
                isEnd = false
                next
            end
            newLexemes.insert(0, @lexemes[i])
            i += 1
        end
        newLexemes.insert(0, @lexemes[@lexemes.length - 1])
        @lexemes = newLexemes.reverse!
        return isEnd
    end

    def Validate
        for i in 0...@lexemes.length - 1
            if ((@lexemes[i] == "+") || (@lexemes[i] == "-") || (@lexemes[i] == "*") || (@lexemes[i] == "/") || (@lexemes[i] == "^"))
                if ((@lexemes[i + 1] == "*") || (@lexemes[i + 1] == "/") || (@lexemes[i + 1] == "^"))
                    abort "Incorrect Opertarors"
                end
            end
            if ((@lexemes[i].to_f.to_s == @lexemes[i]) && (@lexemes[i + 1 ] == "("))
                abort "Incorrect Brackets after number"
            end
        end
        if ((@lexemes[@lexemes.length - 1] == "-") ||
            (@lexemes[@lexemes.length - 1] == "+") ||
            (@lexemes[@lexemes.length - 1] == "*") ||
            (@lexemes[@lexemes.length - 1] == "/"))
                abort "Incorrect Opertarors"
        end
    end

    def CheckUnaryOperators
        newLexemes = []
        i = 0
        while (i < (@lexemes.length - 1))
            if ((@lexemes[i] == "+") || (@lexemes[i] == "-"))
                if ((@lexemes[i + 1].to_f.to_s == @lexemes[i + 1]) || (@lexemes[i + 1].to_i.to_s == @lexemes[i + 1]))
                    if ((i - 1) < 0)
                        newLexemes.insert(0, @lexemes[i] + @lexemes[i + 1])
                        i += 2
                        next
                    end
                    if (((@lexemes[i - 1].to_f.to_s != @lexemes[i - 1]) &&
                         (@lexemes[i - 1].to_i.to_s != @lexemes[i - 1])) &&
                         (@lexemes[i - 1] != ")"))
                        newLexemes.insert(0, @lexemes[i] + @lexemes[i + 1] )
                        i += 2
                        next
                    else
                        newLexemes.insert(0, @lexemes[i])
                    end
                else
                    newLexemes.insert(0, @lexemes[i])
                end
            else
                newLexemes.insert(0, @lexemes[i])
            end
            i += 1
        end
        if (newLexemes.length > 1)
            newLexemes.insert(0, @lexemes[@lexemes.length - 1])
        end
        @lexemes = newLexemes.reverse!
    end

    def Degree
        isEnd = false
        while (!isEnd)
            if (@lexemes.size == 1)
                break
            end
            newLexemes = []
            for i in 0...(@lexemes.length - 2)
                if (@lexemes[i + 1] == "^")
                    value = @lexemes[i].to_f ** @lexemes[i + 2].to_f
                    if (ARGV[1] == "-i")
                        puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                    end
                    newLexemes.insert(0, value)
                    for j in i + 3...(@lexemes.length)
                        newLexemes.insert(0, @lexemes[j])
                    end
                    @lexemes = newLexemes.reverse!
                    if (ARGV[1] == "-i")
                        puts "#{@lexemes}"
                    end
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
                    value = @lexemes[i].to_f * @lexemes[i + 2].to_f
                    if (ARGV[1] == "-i")
                        puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                    end
                    newLexemes.insert(0, value)
                    for j in i + 3...(@lexemes.length)
                        newLexemes.insert(0, @lexemes[j])
                    end
                    @lexemes = newLexemes.reverse!
                    if (ARGV[1] == "-i")
                        puts "#{@lexemes}"
                    end
                    break
                else
                    if (@lexemes[i + 1] == "/")
                        value = @lexemes[i].to_f / @lexemes[i + 2].to_f
                        if (ARGV[1] == "-i")
                            puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                        end
                        newLexemes.insert(0, value)
                        for j in i + 3...(@lexemes.length)
                            newLexemes.insert(0, @lexemes[j])
                        end
                        @lexemes = newLexemes.reverse!
                        if (ARGV[1] == "-i")
                            puts "#{@lexemes}"
                        end
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
                    value = @lexemes[i].to_f + @lexemes[i + 2].to_f
                    if (ARGV[1] == "-i")
                        puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                    end
                    newLexemes.insert(0, value)
                    for j in i + 3...(@lexemes.length)
                        newLexemes.insert(0, @lexemes[j])
                    end
                    @lexemes = newLexemes.reverse!
                    break
                else
                    if (@lexemes[i + 1] == "-")
                        value = @lexemes[i].to_f - @lexemes[i + 2].to_f
                        if (ARGV[1] == "-i")
                            puts "#{@lexemes[i]} #{@lexemes[i + 1]} #{@lexemes[i + 2]} = #{value}"
                        end
                        newLexemes.insert(0, value)
                        for j in i + 3...(@lexemes.length)
                            newLexemes.insert(0, @lexemes[j])
                        end
                        @lexemes = newLexemes.reverse!
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
                if (countCloseBrackets > countOpenBrackets)
                     abort "Incorrect Brackets position"
                end
                if (countOpenBrackets == countCloseBrackets)
                    indexFinish = i
                    break
                end
            end
        end
        if (countOpenBrackets != countCloseBrackets)
            abort "Incorrect number of Brackets"
        end

        if (indexStart != indexFinish)
            newValue = self.GetPath(indexStart + 1, indexFinish).join
            if (ARGV[1] == "-i")
                puts "Brackets values: #{newValue}"
            end
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
