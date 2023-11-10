module TransmissionService

  require 'net/http'
  require 'json'
  require 'uri'

  TRANSMISSION_URL = URI(ENV['TRANSMISSION_URL']+'/transmission/rpc')
  TRANSMISSION_USERNAME = ENV['TRANSMISSION_USERNAME']
  TRANSMISSION_PASSWORD = ENV['TRANSMISSION_PASSWORD']
  TRANSMISSION_DOWNLOAD_DIR = ENV['TRANSMISSION_DIR']

  def self.add_uri(download_link)
    json_rpc_request = {
      method: 'torrent-add',
      arguments: {
        filename: download_link,
        'download-dir': TRANSMISSION_DOWNLOAD_DIR,
        paused: false
      }
    }.to_json
    http = Net::HTTP.new(TRANSMISSION_URL.host, TRANSMISSION_URL.port)

    request = Net::HTTP::Post.new(TRANSMISSION_URL.request_uri, {'Content-Type' => 'application/json', 'X-Transmission-Session-Id' => get_session_id})
    request.basic_auth TRANSMISSION_USERNAME, TRANSMISSION_PASSWORD
    request.body = json_rpc_request

    response = http.request(request)

    JSON.parse(response.body)
  end

  def self.get_session_id
    http = Net::HTTP.new(TRANSMISSION_URL.host, TRANSMISSION_URL.port)
    request = Net::HTTP::Get.new(TRANSMISSION_URL.request_uri)
    request.basic_auth TRANSMISSION_USERNAME, TRANSMISSION_PASSWORD
    response = http.request(request)
    response['X-Transmission-Session-Id']
  end

end