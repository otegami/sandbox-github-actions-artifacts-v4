require 'open-uri'

uri = ENV['ARTIFACT_URL']
access_token = ENV['GITHUB_ACCESS_TOKEN']

# Failed example
# URI(uri).open("Authorization" => "token #{access_token}")

# The following result is what we expected here.
# Because `Authorization` header is still active on redirecting.
# /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:376:in `open_http': 403 Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature. (OpenURI::HTTPError)
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:770:in `buffer_open'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:220:in `block in open_loop'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:218:in `catch'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:218:in `open_loop'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:158:in `open_uri'
# 	from /home/kodama/.rbenv/versions/3.3.2/lib/ruby/3.3.0/open-uri.rb:750:in `open'
# 	from download_artifact.rb:7:in `<main>'

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

# The following result is what we expected here.
# It means you can download the artifact because `Authorization` header is removed on redirecting.
#<URI::HTTPS https://productionresultssa14.blob.core.windows.net/actions-results/
