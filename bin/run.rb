require_relative '../config/environment'

system "clear"

@order_array = []
$prompt = TTY::Prompt.new

opening_graphic
$background_music.play
welcome

