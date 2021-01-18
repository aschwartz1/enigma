require './lib/enigma'
require './lib/file_helper'

# Parse command line arguments
abort('Decryption must be ran with arguments `<input_file> <output_file> <key> <date>`') if ARGV.length != 4
encrypted_file = ARGV[0]
decrypted_file = ARGV[1]
key = ARGV[2]
date = ARGV[3]

# Verify input file exists
file_helper = FileHelper.new
abort("#{encrypted_file} doesn't exist.") unless file_helper.file_exists?(encrypted_file)

# Read in the message from it
message = file_helper.read(encrypted_file)

# Spin up an Enigma instance
enigma = Enigma.new

# Decrypt message
decryption_data = enigma.decrypt(message, key, date)

# Write message to output file
file_helper.write(decryption_data[:decryption], decrypted_file)

# Print output message
puts "Created '#{decrypted_file}' with the key #{decryption_data[:key]} and date #{decryption_data[:date]}"
