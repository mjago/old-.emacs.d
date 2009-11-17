
class Help
  @@key_strokes = {
    'quit' => 'C-x C-c',
    'abort current command' => 'C-g',
    'undo' => 'C-_ or C-x u',
    'tutorial' => 'C-h t',
    'beginning of line' => 'C-a',
    'end of line' => 'C-e',
    'page up' => 'M-v',
    'page down' => 'C-v',
    'beginning of file' => 'M-< or C-Home',
    'end of file' => 'M-> or C-End',
    'centre frame' => 'C-l',
    'centre window' => 'C-l',
    'open' => 'C-x C-f',
    'save' => 'C-x C-s',
    'save as' => 'C-x C-w',
    'switch buffer' => 'C-x b',
    'split frame' => 'C-x 2',
    'single frame' => 'C-x 1',
    'switch frame' => 'C-x 0',
    'split window' => 'C-x 2',
    'single window' => 'C-x 1',
    'switch window' => 'C-x 0',
    'search' => 'C-s',
    'find and replace with verify' => 'M-x replace-string',
    'set mark' => 'C-space',
    'cut' => 'C-w',
    'copy' => 'm-w',
    'paste' => 'C-y',
    'yank' => 'C-y',
    'cut rest of line' => 'C-k',
    'insert comment in code' => 'M-;',
    'comment selected region' => 'M-x comment-region',
    'uncomment selected region' => 'M-x comment-region',
    'x times' => 'C-u x (ie 5) command',
    'record macro' => 'C-x (',
    'stop recording macro' => 'C-x )',
    'run macro' => 'C-x e',
    'complete word' => 'M-/  (if emacs guesses wrong, try again)',    
    'close buffer' => 'C-x k',    
    'kill some buffers' => 'C-x kill-some-buffers',    
    'close some buffers' => 'C-x kill-some-buffers'
  }
  
  def initialize
    STDOUT.puts
    case ARGV[0]
    when '-help', '-h', '-?'
      STDOUT.puts "USAGE:-"
      STDOUT.puts "-help is this page"
      STDOUT.puts "-quiz prompts with random commands, which you should guess"
      STDOUT.puts "-learn iterates through key commands - attempt to predict the answer"
      STDOUT.puts "Otherwise - query mode is assumed..."
      STDOUT.puts "...enter name or part of name of command to be told appropriate key-stroke"
      STDOUT.puts
      @@mode = :exit
    when '-quiz', '-q'
      prepare_for_quiz
      STDOUT.puts "guess key phrases for prompted actions!"
    when :learn
      prepare_for_learn
      STDOUT.puts "iterates through key commands - attempt to predict the answer!"
    else
      @@mode = :query
      STDOUT.puts "enter phrase or part of phrase to find key-stroke"
    end
    STDOUT.puts
    STDOUT.puts "type 'q' to quit" if @mode != :exit
    STDOUT.puts
    STDOUT.flush
  end
  
  def check_for_exit
    puts "key_input = #{@key_input}"
    puts "key_input.class = #{@key_input.class}"
    if (@key_input == 'q' || @key_input == 'Q')
      @@mode = :exit
    end
  end
  
  def exist? input
    if @@key_strokes.include? input.downcase
      true
    else
      false
    end
  end
  
  def partially_exist? input
    @@key_strokes.each_key do |k|
      if k.include? input.downcase
        return true
      end
    end
    false
  end
  
  def print_suggestions input
    @@key_strokes.each_key do |k|
      if k.include? input.downcase
        STDOUT.puts "#{k} = #{@@key_strokes[k]}"
      end
    end
  end
  
  def process
    loop do
      puts @@mode
      await_input
      case @@mode
      when :query
        process_query
      when :quiz
        process_quiz
      when :learn
        process_learn
      when :exit
        puts "exiting"
        break
      end
    end
  end
  
  def await_input
    @key_input = STDIN.gets
    @key_input.chomp
    check_for_exit
#    puts "await_input input = #{@key_input}"
  end
  
  def process_query
    STDOUT.puts
    if exist? @key_input
      STDOUT.puts "#{key_stroke} = #{@key_input}"
    elsif partially_exist? @key_input
      STDOUT.puts "can't find #{@key_input} - do you mean..."
      STDOUT.puts
      print_suggestions @key_input
    else
      STDOUT.puts "unknown key-stroke #{@key_input}"
    end
    STDOUT.puts
    STDOUT.flush
  end

  def process_quiz
    current_guess = (rand * @@number_of_key_strokes).to_i
    puts "#{@@key_strokes.index(@@quiz_strokes[current_guess])} =   ? "
    await_input
    puts "#{@@key_strokes.index(@@quiz_strokes[current_guess])} =    #{@@quiz_strokes[current_guess]} "
  end
  
  def key_stroke
    @@key_strokes[@key_input]
  end
  
  def prepare_for_learn
    @@mode = :learn
    @@quiz_strokes = []
    @@key_strokes.each_key do |k|
      @@quiz_strokes.push @@key_strokes[k]
    end
    @@quiz_strokes.sort!
    @@number_of_key_strokes = @@key_strokes.size
  end
  
  def prepare_for_quiz
    @@mode = :quiz
    @@quiz_strokes = []
    @@key_strokes.each_key do |k|
      @@quiz_strokes.push @@key_strokes[k]
    end 
    @@number_of_key_strokes = @@key_strokes.size
  end
  
  def quiz
    current_guess = (rand * @@number_of_key_strokes).to_i
    puts "#{@@key_strokes.index(@@quiz_strokes[current_guess])} =   ? "
    await_input
    puts "#{@@key_strokes.index(@@quiz_strokes[current_guess])} =    #{@@quiz_strokes[current_guess]} "
  end
end

h = Help.new
h.process
h = nil


