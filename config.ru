require './names.rb'
require 'rack/smack'

use Rack::Smack
use Rack::Deflater

run NamesOfGod.new
