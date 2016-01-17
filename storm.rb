require 'hue'
require 'audite'

@client = Hue::Client.new
@player = Audite.new

@left  = @client.lights[0]
@back  = @client.lights[1]
@right = @client.lights[2]

def strobe(cycles)
  cycles.times do
    rand(3..6).times do
      light = @client.lights[rand(0..2)]
      light.set_state({bri: rand(100..254), on: true, transitiontime: rand(0..4)})
      light.set_state({:on => false, color_temperature: 153, transitiontime: rand(0..4)})
    end
  end
end

def thunder
  thunder_files = ["thunder1.mp3", "thunder2.mp3", "thunder3.mp3", "thunder4.wav"]
  audio_file = thunder_files[rand(thunder_files.length)]

  system "afplay #{audio_file}"
end


while true do
  puts "\n"
  puts "------------Lightning Strike-------------------"
  strobe(1)
  sleep(rand(0..3))

  puts "Thunder Clap"
  thunder

  sleep_time = rand(0..600)
  puts "Sleeping for #{sleep_time/60} minutes"
  sleep(sleep_time)
  puts "-------------Waking-------------------------"
end
