
@timestamp = File.atime("shoes.rb")
loop do
	if not File.atime("shoes.rb") == @timestamp
		@timestamp = File.atime("shoes.rb")
		#~ STDOUT.puts "running app"
		#~ STDOUT.flush
		`\"C:\\Program Files\\Common Files\\Shoes\\0.r1134\\shoes.exe\" c:\\ruby_code\\shoes\\shoes.rb`
	end
	sleep 0.5
	STDOUT.puts File.atime("shoes.rb")
	STDOUT.flush
end