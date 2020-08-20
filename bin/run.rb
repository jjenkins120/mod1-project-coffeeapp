require_relative '../config/environment'

system "clear"

$prompt = TTY::Prompt.new
opening_graphic
$background_music.play
welcome

