module Obtuse
  class CLI
    def initialize(argv)
      repl # Just start the REPL for now
    end

    def repl
      require "readline"
      puts "Obtuse Programming Language"
      puts 'Type "stack" or "s" to print the complete stack.'
      puts 'Type "exit" or hit Ctrl-D to exit'
      prompt = "> "

      evaluator = Evaluator.new
      loop do
        line = Readline::readline(prompt)

        if line.nil? or line == "exit"
          puts if line.nil?
          puts "Bye!"
          exit 0
        end

        next if line.empty?

        Readline::HISTORY << line

        begin
          if line == "s" || line == "stack"
            p evaluator.stack
          else
            evaluator.eval line
            p evaluator.peek if evaluator.peek
          end
        rescue Exception => e
          puts e.message
          puts e.backtrace
        end
      end
    end
  end
end
