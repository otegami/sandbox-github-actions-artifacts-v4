require 'open-uri'

uri = ENV['ARTIFACT_URL']
access_token = ENV['GITHUB_ACCESS_TOKEN']

# Failed example
# URI(uri).open("Authorization" => "token #{access_token}")

# succeeded example
headers = {
  "Authorization" => "token #{access_token}",
  redirect: false
}

loop do
  begin
    URI.open(uri, headers)
    break
  rescue OpenURI::HTTPRedirect => redirect
    headers.delete("Authorization")
    pp uri = redirect.uri
 end
end
