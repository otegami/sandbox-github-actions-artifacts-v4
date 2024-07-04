require 'open-uri'

url = ENV['ARTIFACT_URL']
access_token = ENV['GITHUB_ACCESS_TOKEN']

# Error case
# URI(url).open("Authorization" => "token #{access_token}") do |artifact|
#   File.open("artifact.yml", "wb") do |file|
#     file.write(artifact.read)
#   end
# end

# Error case when using redirect false
# Success case when using redirect true
headers = {
  "Authorization" => "token #{access_token}",
  redirect: false
}

uri = URI(url)
response = nil

loop do
  begin
    response = URI.open(uri.to_s, headers)
    break
  rescue OpenURI::HTTPRedirect => redirect
    uri = redirect.uri
    headers = {}
  end
end

File.open("artifact.yml", "wb") do |file|
	file.write(response.read)
end
