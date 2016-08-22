require './lib/main'
$stdout.sync = true
use Rack::MobileDetect
run Main
