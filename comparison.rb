require 'histogram'
require 'histogram/array'
require 'pathname'

LDL = {

  :mac => [
  
    "vendor/lora_device_lib/src/ldl_mac.c",
    "vendor/lora_device_lib/src/ldl_mac_commands.c",
    "vendor/lora_device_lib/src/ldl_frame.c",
    "vendor/lora_device_lib/src/ldl_ops.c",
    "vendor/lora_device_lib/src/ldl_sm.c",
    "vendor/lora_device_lib/src/ldl_stream.c",
    "vendor/lora_device_lib/src/ldl_system.c",
    
    "vendor/lora_device_lib/include/ldl_mac.h",
    "vendor/lora_device_lib/include/ldl_mac_commands.h",
    "vendor/lora_device_lib/include/ldl_frame.h",
    "vendor/lora_device_lib/include/ldl_ops.h",
    "vendor/lora_device_lib/include/ldl_sm.h",
    "vendor/lora_device_lib/include/ldl_sm_internal.h",
    "vendor/lora_device_lib/include/ldl_stream.h",
    "vendor/lora_device_lib/include/ldl_system.h",
    
    "vendor/lora_device_lib/include/ldl_debug.h",
    "vendor/lora_device_lib/include/ldl_platform.h"
  
  ],
  
  :radio => [
  
    "vendor/lora_device_lib/src/ldl_radio.c",
    
    "vendor/lora_device_lib/include/ldl_radio.h",
    "vendor/lora_device_lib/include/ldl_radio_defs.h",
    "vendor/lora_device_lib/include/ldl_chip.h",
  
  ],
  
  :region => [
  
      "vendor/lora_device_lib/src/ldl_region.c",
      
      "vendor/lora_device_lib/include/ldl_region.h",
  
  ]

}

LORAMAC = {

  :mac => [

    "vendor/LoRaMac-node/src/mac/LoRaMac.c",
    "vendor/LoRaMac-node/src/mac/LoRaMacCommands.c",
    "vendor/LoRaMac-node/src/mac/LoRaMacConfirmQueue.c",
    "vendor/LoRaMac-node/src/mac/LoRaMacSerializer.c",
    "vendor/LoRaMac-node/src/mac/LoRaMacAdr.c",
    "vendor/LoRaMac-node/src/mac/LoRaMacParser.c",
    "vendor/LoRaMac-node/src/mac/LoRaMacCrypto.c",
    "vendor/LoRaMac-node/src/system/timer.c",
    "vendor/LoRaMac-node/src/peripherals/soft-se/soft-se.c",
    
    "vendor/LoRaMac-node/src/mac/LoRaMacConfirmQueue.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacCommands.h",
    
    "vendor/LoRaMac-node/src/mac/LoRaMacMessageTypes.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacHeaderTypes.h",
    
    "vendor/LoRaMac-node/src/mac/LoRaMacParser.h",
    "vendor/LoRaMac-node/src/mac/LoRaMac.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacTypes.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacAdr.h",
    "vendor/LoRaMac-node/src/mac/secure-element.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacSerializer.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacCrypto.h",
    "vendor/LoRaMac-node/src/mac/LoRaMacTest.h",
    "vendor/LoRaMac-node/src/system/timer.h"
  ],
  
  :radio => [
  
    "vendor/LoRaMac-node/src/radio/sx1276/sx1276.c",
    "vendor/LoRaMac-node/src/radio/sx1272/sx1272.c",

    "vendor/LoRaMac-node/src/radio/sx1276/sx1276Regs-LoRa.h",
    "vendor/LoRaMac-node/src/radio/sx1276/sx1276Regs-Fsk.h",
    "vendor/LoRaMac-node/src/radio/sx1276/sx1276.h",
    "vendor/LoRaMac-node/src/radio/sx1272/sx1272Regs-LoRa.h",
    "vendor/LoRaMac-node/src/radio/sx1272/sx1272.h",
    "vendor/LoRaMac-node/src/radio/sx1272/sx1272Regs-Fsk.h",
    "vendor/LoRaMac-node/src/radio/radio.h"
  ],
  
  :region => [
  
    "vendor/LoRaMac-node/src/mac/region/Region.c",
    "vendor/LoRaMac-node/src/mac/region/RegionAU915.c",
    "vendor/LoRaMac-node/src/mac/region/RegionCommon.c",
    "vendor/LoRaMac-node/src/mac/region/RegionEU433.c",
    "vendor/LoRaMac-node/src/mac/region/RegionEU868.c",
    "vendor/LoRaMac-node/src/mac/region/RegionUS915.c",
    
    "vendor/LoRaMac-node/src/mac/region/Region.h",     
    "vendor/LoRaMac-node/src/mac/region/RegionEU868.h",
    "vendor/LoRaMac-node/src/mac/region/RegionEU433.h",
    "vendor/LoRaMac-node/src/mac/region/RegionUS915.h",
    "vendor/LoRaMac-node/src/mac/region/RegionAU915.h",
    "vendor/LoRaMac-node/src/mac/region/RegionCommon.h"   
  ]

}

NAMES = {

  LDL => "LDL",
  LORAMAC => "LoRaMAC-Node"
}

def self.select(proj, *group)

  if not group.empty?

    proj.select{|k,v| group.include?(k)}.values.flatten
    
  else
    
    proj.values.flatten
    
  end
  
end

McResult = Struct.new(:file, :score, :statements, :lines, :functions)
McFunction = Struct.new(:file, :name, :score, :statements, :lines)

def self.mccabe(file)
  
  r = /(?<score>[0-9]+)\s([0-9]+)\s(?<statements>[0-9]+)\sn\/a\s(?<lines>[0-9]+)/.match(`pmccabe -T #{file}`)
  
  retval = McResult.new(file, r[:score].to_i, r[:statements].to_i, r[:lines].to_i, [])
  
  `pmccabe #{file}`.each_line do |line|
  
    #puts line
  
    l = /(?<score>[0-9]+)\s([0-9]+)\s(?<statements>[0-9]+)\s([0-9]+)\s(?<lines>[0-9]+)\s([^ ]+)\s(?<name>[^ ]+)?/.match(line)  
  
    retval.functions << McFunction.new(file, l[:name].strip, l[:score].to_i, l[:statements].to_i, l[:lines].to_i)
    
  end
  
  retval
  
end


def self.each_group(*proj)
  
  LDL.keys.each do |group|
  
    arg = proj.map{|p|select(p, group).map{|f| mccabe(f)}}
  
    yield(group, *arg)
  
  end
  
end

def self.each(*proj)

  arg = proj.map{|p|select(p).map{|f| mccabe(f)}}
  
  yield(*arg)
  
end

def self.count_lines(result)

  result.map{|r|r.lines}.inject(0, :+)

end

def self.count_statements(result)

  result.map{|r|r.statements}.inject(0, :+)

end

def self.count_score(result)

  result.map{|r|r.score}.inject(0, :+)

end

def self.count_fn(result)

  result.map{|f|f.functions}.flatten.size

end

def self.path(root, filename)
  filename[/(?=#{root}).*/]  
end

SizeLine = Struct.new(:text, :data, :bss, :desc, keyword_init: true)

def self.parse_size(recipe)

  lines = `make -j4 #{recipe}`.split(/\n+/)
  
  # remove first line
  lines.shift
  
  result = []
  
  lines.each do |line|
  
    match = /(?<text>[0-9]+)\s*(?<data>[0-9]+)\s*(?<bss>[0-9]+)\s*(?<dec>[0-9]+)\s*(?<hex>[0-9a-zA-Z]+)\s*(?<desc>[^ ]+)/.match(line)
    
    if match
    
      result << SizeLine.new(text: match[:text].to_i, data: match[:data].to_i, bss: match[:bss].to_i, desc: match[:desc].dup)
    
    end
  
  end
  
  result
  
end

########################################################################



puts "## Overall Results"
puts ""

[LDL, LORAMAC].each do |proj|

  print "<table>"
  print  "<caption>#{NAMES[proj]} PMCCABE Results</caption>"  
  print  "<header>"
  print    "<tr>"
  print      "<th>Domain</th>"
  print      "<th>LoC</th>"
  print      "<th>Functions</th>"
  print      "<th>Statements</th>"
  print      "<th>Complexity</th>"
  print    "</tr>"
  print  "</header>"
  print  "<tbody>"
  
  each_group(proj) do |group, result|
  
    print    "<tr>"
    print      "<td>#{group.to_s.capitalize}</td>"
    print      "<td>#{count_lines(result)}</td>"
    print      "<td>#{count_fn(result)}</td>"
    print      "<td>#{count_statements(result)}</td>"
    print      "<td>#{count_score(result)}</td>"
    print    "</tr>"
  
  end
  
  each(proj) do |result|
  
    print    "<tr>"
    print      "<td></td>"
    print      "<td><b>#{count_lines(result)}</b></td>"
    print      "<td><b>#{count_fn(result)}</b></td>"
    print      "<td><b>#{count_statements(result)}</b></td>"
    print      "<td><b>#{count_score(result)}</b></td>"
    print    "</tr>"
    
  end
  
  print    "</tbody>"  
  print  "</table>"  
  
  puts ""
  puts ""
  
  
end

puts "Lines of Code"
puts "domain, LDL, LoRaMac-Node"
each_group(LDL, LORAMAC) do |group, ldl, loramac|
  puts "#{group}, #{count_lines(ldl)}, #{count_lines(loramac)}"
end
puts ""

puts "Number of Functions"
puts "domain, LDL, LoRaMac-Node"
each_group(LDL, LORAMAC) do |group, ldl, loramac|
  puts "#{group}, #{count_fn(ldl)}, #{count_fn(loramac)}"
end
puts ""

puts "Number of Statements"
puts "domain, LDL, LoRaMac-Node"
each_group(LDL, LORAMAC) do |group, ldl, loramac|
  puts "#{group}, #{count_statements(ldl)}, #{count_statements(loramac)}"
end
puts ""

puts "Cyclomatic Complexity"
puts "domain, LDL, LoRaMac-Node"
each_group(LDL, LORAMAC) do |group, ldl, loramac|
  puts "#{group}, #{count_score(ldl)}, #{count_score(loramac)}"
end
puts ""

puts ""
puts "## function complexity per group"
puts ""

each_group(LDL, LORAMAC) do |group, ldl, loramac|

  ldl = ldl.map{|r|r.functions}.flatten
  loramac = loramac.map{|r|r.functions}.flatten
  
  bins, result1, result2 = ldl.map{|f|f.score}.histogram(30, min: 2.0, bin_width: 2.0, other_sets: [ loramac.map{|f|f.score} ])
  
  puts ""
  puts "  ### #{group}"
  puts ""
  
  puts ""
  puts "    bin, LDL, LoRaMac-Node"
  bins.each.with_index do |b,i|
  
    puts "    #{b}, #{result1[i]}, #{result2[i]}"
    
  end
  
  puts ""
  
  [ldl, loramac].each do |proj|  
  
    print "<table>"  
    print  "<caption>#{proj == ldl ? "LDL" : "LoRaMac-Node"} Most Complicated #{group.capitalize} Functions</caption>"  
    print  "<theader>"
    print    "<tr>"
    print      "<th>#</th>"
    print      "<th>Complexity</th>"
    print      "<th>LoC</th>"
    print      "<th>Statements</th>"
    print      "<th>Name</th>"
    print    "</tr>"
    print  "</theader>"
    print  "<tbody>"
    
    proj.sort_by{|r|r.score}.reverse.first(5).each.with_index do |r, i|    
      print "<tr>"
      print  "<th>#{i+1}</th>"
      print  "<td>#{r.score}</td>"      
      print  "<td>#{r.lines}</td>"
      print  "<td>#{r.statements}</td>"
      print  "<td>#{r.name}</td>"
      print "</tr>"
    end
  
    print "</tbody>"
    print "</table>"
    puts ""
    puts ""
    
  end
  
  
  
  
  
end


puts ""
puts "## Compiled Size"
puts ""

bla = {
  
  
  "LDL" => {
  
    "Region" => parse_size('size_ldl_region'),
    "Radio" =>  parse_size('size_ldl_radio'),
    "MAC" =>    parse_size('size_ldl_mac')  
  },
  
  "LoRaMAC-Node" => {
 
    "Region" => parse_size('size_loramac_region'),
    "Radio" =>  parse_size('size_loramac_radio'),
    "MAC" =>    parse_size('size_loramac_mac')
  }
}

bla.each do |name, data|

    print "<table>"
    print   "<caption>#{name} Compiled Size</caption>"

    print   "<theader>"
    print     "<tr>"
    print     "<th>Object File (from *.c)</th>"
    print     "<th>Text (bytes)</th>"
    print     "<th>BSS+Data (bytes)</th>"
    print     "</tr>"
    print   "</theader>"
    print   "<tbody>"
  
    all_data = data.values.flatten
  
    all_data.each do |bla|
      
        print   "<tr>"
        print     "<td>#{bla.desc}</td>"
        print     "<td>#{bla.text}</td>"
        print     "<td>#{bla.bss + bla.data}</td>"
        print   "</tr>"
        
    end
    
    print     "<tr>"
    print       "<td></td>"
    print       "<td><b>#{all_data.map{|vv|vv.text}.inject(0, :+)}</b></td>"
    print       "<td><b>#{all_data.map{|vv|vv.bss}.inject(0, :+) + all_data.map{|vv|vv.data}.inject(0, :+)}</b></td>"
    print     "</tr>"
    
    print   "</tbody>"
    print "</table>"
    
    puts ""
    puts ""
    

end



  puts "Flash"
  puts "Domain, LDL, LoRaMAC-Node"
  puts "MAC, #{parse_size('size_ldl_mac').map{|r|r.text}.inject(0, :+)}, #{parse_size('size_loramac_mac').map{|r|r.text}.inject(0, :+)}"
  puts "Radio, #{parse_size('size_ldl_radio').map{|r|r.text}.inject(0, :+)}, #{parse_size('size_loramac_radio').map{|r|r.text}.inject(0, :+)} "
  puts "Region, #{parse_size('size_ldl_region').map{|r|r.text}.inject(0, :+)}, #{parse_size('size_loramac_region').map{|r|r.text}.inject(0, :+)}"
  
  puts ""
  
  puts "RAM"
  puts "Domain, LDL, LoRaMAC-Node"
  puts "MAC, #{parse_size('size_ldl_mac').map{|r|r.data + r.bss}.inject(0, :+)}, #{parse_size('size_loramac_mac').map{|r|r.data + r.bss}.inject(0, :+)}"
  puts "Radio, #{parse_size('size_ldl_radio').map{|r|r.data + r.bss}.inject(0, :+)}, #{parse_size('size_loramac_radio').map{|r|r.data + r.bss}.inject(0, :+)} "
  puts "Region, #{parse_size('size_ldl_region').map{|r|r.data + r.bss}.inject(0, :+)}, #{parse_size('size_loramac_region').map{|r|r.data + r.bss}.inject(0, :+)}"
