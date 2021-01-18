require './lib/enigma'
require './lib/file_helper'
require 'time'

# Parse command line arguments
abort('Encryption must be ran with BOTH an input and output file.') if ARGV.length != 2
input_file = ARGV[0]
output_file = ARGV[1]

# Verify input file exists
file_helper = FileHelper.new
abort("#{input_file} doesn't exist.") unless file_helper.file_exists?(input_file)

# Read in the message from it
message = file_helper.read(input_file)

# Spin up an Enigma instance
enigma = Enigma.new

# Encrypt message
encryption_data = enigma.encrypt(message, '02715', Date.new(1995, 8, 4))

# Write message to output file
file_helper.write(encryption_data[:encryption], output_file)

# Print output message
puts "Created '#{output_file}' with the key #{encryption_data[:key]} and date #{encryption_data[:date]}"

# Profit
