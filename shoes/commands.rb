require "yaml"

@keystrokes = {
	:open_file => ['Ctrl x','Ctrl f'],
	:quit => [ 'Ctrl x','Ctrl c'],
	:save_a_file_back_to_disk => ['Ctrl x','Ctrl s'],
	:save_all_files => ['Ctrl x','s'],
	:insert_contents_of_another_file_into_this_buffer => ['Ctrl x','i'],
	:replace_this_file_with_the_file_you_really_want => ['Ctrl x','Ctrl v'],
	:write_buffer_to_a_specified_file => ['Ctrl x','Ctrl w'],
	:recover_a_file_lost_by_a_system_crash =>	['Alt x','r','e','c','o','v','e','r','-','f','i','l','e'],
	:recover_files_from_previous_session =>	['Alt x','r','e','c','o','v','e','r','-','s','e','s','s','i','o','n']
}	

puts @keystrokes.inspect
puts 
puts 

File.open('c:/ruby_code/shoes/temp.yml','w') do |out|
	YAML.dump(@keystrokes, out)
end

test = YAML::load_file('c:/ruby_code/shoes/temp.yml')

puts test.inspect

def this_is_a_test
    ok_indent_too_big
end

