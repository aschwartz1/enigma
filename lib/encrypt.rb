require './lib/enigma'
require './lib/file_helper'
require 'time'

# Parse command line arguments
abort('Encryption must be ran with arguments `<original_file> <encrypted_file>`') if ARGV.length != 2
original_file = ARGV[0]
encrypted_file = ARGV[1]

# Verify input file exists
file_helper = FileHelper.new
abort("#{original_file} doesn't exist.") unless file_helper.file_exists?(original_file)

# Read in the message from it
message = file_helper.read(original_file)

# Spin up an Enigma instance
enigma = Enigma.new

# Encrypt message
encryption_data = enigma.encrypt(message, '02715', '040895')

# Write message to output file
file_helper.write(encryption_data[:encryption], encrypted_file)

# Print output message
puts "Created '#{encrypted_file}' with the key #{encryption_data[:key]} and date #{encryption_data[:date]}"
