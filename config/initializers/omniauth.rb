Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :github, ENV["GITHUB_TOKEN"], ENV["GITHUB_SECRET"], scope: "repo"
  provider :github, ENV["GITHUB_TOKEN"], ENV["GITHUB_SECRET"]
end
