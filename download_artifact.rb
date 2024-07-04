require 'open-uri'

url = ENV['ARTIFACT_URL']
access_token = ENV['GITHUB_ACCESS_TOKEN']

# URI(url).open("Authorization" => "token #{access_token}") do |artifact|
#   File.open("artifact.yml", "wb") do |file|
#     file.write(artifact.read)
#   end
# end

# /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:376:in `open_http': 401 Unauthorized (OpenURI::HTTPError)
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:770:in `buffer_open'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:220:in `block in open_loop'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:218:in `catch'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:218:in `open_loop'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:158:in `open_uri'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:750:in `open'
# 	from download_artifact.rb:8:in `<main>'

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
