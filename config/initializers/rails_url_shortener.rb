CHARSETS = {
  alphanum: ("a".."z").to_a + (0..9).to_a,
  alphacase: ("a".."z").to_a + ("A".."Z").to_a,
  alphanumcase: ("A".."Z").to_a + ("a".."z").to_a + (0..9).to_a,
}

RailsUrlShortener.host = ENV["HOST"] || "localhost:3000"           # the host used for the helper
RailsUrlShortener.default_redirect = "/"            # where the users are redirect if the link doesn't exists or is expired.
RailsUrlShortener.charset = CHARSETS[:alphanumcase] # used for generate the keys, better long.
RailsUrlShortener.key_length = 6                    # Key length for random generator
RailsUrlShortener.minimum_key_length = 3            # minimun permited for a key
RailsUrlShortener.save_bots_visits = false          # if save bots visits

Rails.configuration.to_prepare do
  RailsUrlShortener::Visit.class_eval {
    broadcasts_to ->(visit) { :visits_list }, partial: "shared/visit", target: "visits"
  }
  # WARNING
  # This was made only for workaround a problem with docker and nginx.
  ActionDispatch::Request.class_eval {
    def ip
      get_header("X-Real-IP") || @ip || super
    end
  }
end
