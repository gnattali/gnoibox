module Gnoibox
  class GoogleAnalytics
    API_VERSION = 'v3'
    API_CACHE_KEY = "google-analytics-api-#{API_VERSION}"
    
    def initialize(options = {})
      opts.merge(options)

      client.authorization = Signet::OAuth2::Client.new(
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience: 'https://accounts.google.com/o/oauth2/token',
        scope: 'https://www.googleapis.com/auth/analytics.readonly',
        issuer: opts[:service_account_email],
        signing_key: Google::APIClient::KeyUtils.load_from_pkcs12(opts[:key_file], opts[:key_secret])
      )
      client.authorization.fetch_access_token!
    end
    
    def opts
      @opts ||= (Gnoibox::GOOGLE_API_CLIENT_ID || {}).with_indifferent_access 
    end

    def profile_id
      @profile_id ||= opts[:profileID].to_s
    end
    
    def client
      @client ||= Google::APIClient.new(application_name: opts[:application_name], application_version: opts[:application_version])
    end
    
    def analytics
      @analytics ||= begin
        Rails.cache.fetch("#{API_CACHE_KEY}", expires_in: 1.month) do
          client.discovered_api('analytics', API_VERSION)
        end
      end
    end
    
    def query (dimension, metric, sort, startDate = DateTime.now.prev_month.strftime("%Y-%m-%d"), endDate = DateTime.now.strftime("%Y-%m-%d"))
      client.execute(
        api_method: analytics.data.ga.get,
        parameters: {
          'ids' => "ga:" + profile_id,
          'start-date' => startDate,
          'end-date' => endDate,
          'dimensions' => dimension,
          'metrics' => metric,
          'sort' => sort
        }
      )
    end
    
  end
end
