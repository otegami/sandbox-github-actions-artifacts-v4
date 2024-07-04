require 'open-uri'

uri = ENV['ARTIFACT_URL']
access_token = ENV['GITHUB_ACCESS_TOKEN']

headers = {
  "Authorization" => "token #{access_token}",
  redirect: false
}

response = nil

loop do
  begin
    response = URI.open(uri, headers)
    break
  rescue OpenURI::HTTPRedirect => redirect
    pp uri = redirect.uri
  end
end

pp response
