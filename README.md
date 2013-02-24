# ReversePolishCalculator

Do math in [Reverse Polish Notation][1] using the command line tool `rpn` or in
Ruby.

ReversePolishCalculator maintains a stack of values, both from the inputs and
from calculations done using given operators and values.

## Operators

All methods defined by Ruby's Float class that return a number are valid
operators, including: `+` `-` `*` `/` `**` `%` `abs` `round` and [more][2].
    
[1]: http://en.wikipedia.org/wiki/Reverse_Polish_notation
[2]: http://www.ruby-doc.org/core-1.9.3/Float.html

## Command Line Usage

Fire up the command line tool with `rpn`.

Each line read from $stdin will be evaluated, with values and operators
separated by spaces. The value at the top of the stack will be printed. Any
values remaining on the stack persist for the next operation.

    $ rpn
    > 2 3 + 3 -
    2.0

    > 2 +
    4.0

    > +
    ! Not enough operands [4.0] to perform "+"

Finish your session with ^D or q by itself on a line.

rpn will also read from a pipe:

    $ echo '1 2 3 + 3 -' > expressions.txt
    $ echo '-5.7 abs round' >> expressions.txt
    $ rpn < file
    2.0
    6.0

## Library Usage

ReversePolishCalculator#calculate accepts a string or IO stream to evaluate.

If a block is given, calculate yields the stack (and an error, if any) after
each line is processed.

The value at the top of the stack is returned when evaluation has completed.
If an error occurs, nil is returned, and the error is yielded to the block.

    require 'reverse_polish_notation'
    ReversePolishCalculator.calculate('6 3 /')
    # => 2.0

    ReversePolishCalculator.calculate('/')
    # => nil

    ReversePolishCalculator.calculate(File.open('expressions.txt')) do |stack, error|
      # Check for errors.
      # stack.last is the value at the top of the stack.
    end

Copyright (c) 2013 Edward Anderson
