
class EmacsTrainer

  def initialize
    @key_strokes = {
      :open_file => [
                     'Ctrl x','Ctrl f'
                    ],
      :quit => [
                'Ctrl x','Ctrl c'
               ],
      :save_a_file_back_to_disk => [
                                    'Ctrl x','Ctrl s'
                                   ],
      :save_all_files => [
                          'Ctrl x','s'
                         ],
      :insert_contents_of_another_file_into_this_buffer => [
                                                            'Ctrl x','i'
                                                           ],
      :replace_this_file_with_the_file_you_really_want => [
                                                           'Ctrl x','Ctrl v'
                                                          ],
      :write_buffer_to_a_specified_file => [
                                            'Ctrl x','Ctrl w'
                                            #~ ],
                                            #~ :help => [
                                            #~ 'Ctrl h'
                                            #~ ],
                                            #~ :quit_help_window => [
                                            #~ 'q'
                                            #~ ],
                                            #~ :scroll_help_window => [
                                            #~ ' '
                                           ]
    }	
    @expected_key_stroke = :open_file
    @key_pressed = ""
    @key_stroke_count = @key_strokes[@expected_key_stroke].size
    @key_stroke_index = 0
    @count = 0
    @actual_key_stroke = ""
    @score = 0
    @tests_taken = 0
  end


  #   #   #   #   

  def decode_key(key)
    @key_pressed.replace key
    case @key_pressed
    when 'a'.. 'z' , 'A' .. 'Z'
      @actual_key_stroke = "#{@key_pressed}"
    when '0' .. '9' 
      @actual_key_stroke = "#{@key_pressed}"
    else
      case @key_pressed[0]
      when 1 .. 26 
        @actual_key_stroke = "Ctrl #{('a'[0] + @key_pressed[0] - 1).chr}"
      else
        @actual_key_stroke = "no!"
      end
    end
    @actual_key_stroke	
  end

  #   #   #   #   

  def key_correct?
    @actual_key_stroke.to_s == @key_strokes[@expected_key_stroke][@count].to_s
  end

  #   #   #   #   

  def sequence_complete?
    @key_stroke_count == @count + 1
  end	

  #   #   #   #   

  def next_key
    @count += 1
  end
  
  #   #   #   #   

  def repeat_key
    @count = 0
  end

  #   #   #   #   

  def next_sequence
    @key_stroke_index += 1
    @key_stroke_index  = 0 if (@key_stroke_index >= @key_strokes.size)
    @expected_key_stroke = @key_strokes.keys[@key_stroke_index]
    @count = 0
  end

  #   #   #   #   

  def key_stroke
    @key_strokes[@expected_key_stroke]
  end

  #   #   #   #   

  def next_guess
    "#{@expected_key_stroke.to_s}"
  end
  
  #   #   #   #   

  def correct_guess_message
    "#{@expected_key_stroke.to_s}"
  end
  
  def incorrect_guess_message
    "No! #{key_stroke.join(' ')}"
  end

  def score
    @tests_taken += 1
    "#{@score}-#{(@tests_taken)}\n"
  end
  
  def increment_score
    @score += 1
  end
    
end


#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   

Shoes.app(	:title => "Emacs Trainer" ,
                :weight => 'bold' ,
                :width => 760, 
                :height => 572, 
                :resizable => false
                ) do
  stack do
    #~ background "emacs.jpg"
    @correct_guess = "test text"
    emacs = EmacsTrainer.new
    emacs.next_sequence
    para emacs.next_guess , :weight => 'bold' , :stroke => slateblue, :left => 5, :top => 0
    keypress do |k|
      emacs.decode_key k
      if emacs.key_correct?
        if emacs.sequence_complete?
          
          para emacs.correct_guess_message,:weight => 'bold' , :stroke => green, :left => 5
          para " is Correct!",:weight => 'bold' , :stroke => green
          emacs.increment_score
          para emacs.score,:weight => 'bold' , :left => 700
          sleep 0.5
          emacs.next_sequence	
          slot.scroll_top = slot.scroll_max
          para emacs.next_guess , :weight => 'bold' , :stroke => slateblue, :left => 5
        else
          emacs.next_key
        end
      else
        para emacs.incorrect_guess_message,:weight => 'bold' , :stroke => red
        para emacs.score,:weight => 'bold' , :left => 700
        emacs.repeat_key	
        para emacs.next_guess , :weight => 'bold' , :stroke => slateblue, :left => 5
      end
    end
  end
end

