require 'webrick'

root = File.expand_path '~/app'
server = WEBrick::HTTPServer.new port: 3000, DocumentRoot: root
trap 'INT' do server.shutdown end
server.start

server.mount_proc '/' do |req,res|

end