OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  "391331484286-bmjh3lmgabr0pdgfb2o28aufg4g9ejrv.apps.googleusercontent.com",
  "3o2nsTikFCEC7Z3n0dkFRP_L",
  {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
