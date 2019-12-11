require 'fileutils'
require 'pp'

src = Dir["src/mac/**/*.c"] + Dir["src/radio/**/*.c"] + Dir["src/system/**/*.c"] + Dir["src/peripherals/soft-se/**/*.c"]
headers = Dir["src/mac/**/*.h"] + Dir["src/radio/**/*.h"] + Dir["src/system/**/*.h"] + Dir["src/peripherals/soft-se/**/*.h"]

#pp src
#pp headers

mode = nil

if mode == :make

  src.each do |src|

    puts "SRC += #{src}"

  end

  puts ""
  puts ""

  headers.each do |src|

    puts "HDR += #{src}"

  end
  
else

  src.each do |src|
  
    puts "\"#{src}\""
  
  end
  
  puts ""
  puts ""
  
  headers.each do |src|
  
    puts "\"#{src}\""
  
  end

end
