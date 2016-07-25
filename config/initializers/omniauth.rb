Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_ID"], ENV["GOOGLE_SECRET"],
  {
    scope: "profile",
    image_aspect_ratio: "square",
    image_size: 48,
    access_type: "online",
    name: "google"
  }
  OmniAuth.config.full_host = Rails.env.production? ? "https://domain.com" : "http://localhost:3000"
end
