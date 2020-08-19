
def opening_graphic_first_color
puts "
  ,-``-.                            
_r-----i          _
 |     |-.      ,###.
 |     | |    ,-------.
 |     | |   c|       |                       ,--.
 |     |'     |       |      _______________ C|  |
 (=====)      =========       |____________|  `=='   
(HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH)
"
puts "
██╗  ██╗   ██╗        ██╗     ██████╗ █████╗ ███████╗███████╗
██║ ██╔╝   ██║        ██║    ██╔════╝██╔══██╗██╔════╝██╔════╝
█████╔╝ ████████╗     ██║    ██║     ███████║█████╗  █████╗  
██╔═██╗ ██╔═██╔═╝██   ██║    ██║     ██╔══██║██╔══╝  ██╔══╝  
██║  ██╗██████║  ╚█████╔╝    ╚██████╗██║  ██║██║     ███████╗
╚═╝  ╚═╝╚═════╝   ╚════╝      ╚═════╝╚═╝  ╚═╝╚═╝     ╚══════╝
".colorize(:cyan)
sleep(0.1)
end

def opening_graphic_second_color
system "clear"
puts "
  ,-``-.                            
_r-----i          _
 |     |-.      ,###.
 |     | |    ,-------.
 |     | |   c|       |                       ,--.
 |     |'     |       |      _______________ C|  |
 (=====)      =========       |____________|  `=='   
(HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH)
"
puts "
██╗  ██╗   ██╗        ██╗     ██████╗ █████╗ ███████╗███████╗
██║ ██╔╝   ██║        ██║    ██╔════╝██╔══██╗██╔════╝██╔════╝
█████╔╝ ████████╗     ██║    ██║     ███████║█████╗  █████╗  
██╔═██╗ ██╔═██╔═╝██   ██║    ██║     ██╔══██║██╔══╝  ██╔══╝  
██║  ██╗██████║  ╚█████╔╝    ╚██████╗██║  ██║██║     ███████╗
╚═╝  ╚═╝╚═════╝   ╚════╝      ╚═════╝╚═╝  ╚═╝╚═╝     ╚══════╝
".colorize(:green)  
sleep(0.1)
system "clear"
end 

def opening_graphic
  20.times do
  opening_graphic_first_color
  opening_graphic_second_color
  end
  opening_graphic_first_color
  sleep(3)
  puts "\t\tKimberlyn and Jeff ©2020"
  sleep(4)
end