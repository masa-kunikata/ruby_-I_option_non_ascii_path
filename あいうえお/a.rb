if $VERBOSE
  puts 'pp $LOAD_PATH'
  pp $LOAD_PATH
  puts '=============================================='
  puts "  Encoding.default_external: #{Encoding.default_external}"
  puts "  Encoding.default_internal: #{Encoding.default_internal}"
  puts '=============================================='
  puts '$LOAD_PATH'
  $LOAD_PATH.each.with_index do |lp, idx|
    puts "  #{idx}"
    puts "    path: #{lp}"
    puts "    encoding: #{lp.encoding}"
  end
  puts '=============================================='
end

require 'b'
puts 'feature loaded!'