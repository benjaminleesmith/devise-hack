# Provide a simple gemspec so you can easily use your
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "devise_hack"
  s.summary = "DO NOT USE: this is an example of how easy it is to compromise a Rails app using a malicious gem."
  s.description = "DO NOT USE: this is an example of how easy it is to compromise a Rails app using a malicious. If devise is loaded, it will log usernames and passwords to an html file in the public directory."
  s.authors = ['Benjamin Smith  ']
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
end
