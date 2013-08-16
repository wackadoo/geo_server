require 'five_d/access_token'
require 'httparty'

module GameServer

  class Access
    
    def initialize(attributes = {})
      @attributes = attributes
    end

    def fetch_fundamental_character_self(auth_token)
      HTTParty.get(@attributes[:game_server_base_url] + '/fundamental/characters/self', :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ auth_token }"})
    end
  
    protected
      
      def post(path, body = {})
        #add_auth_token(body)
        HTTParty.post(@attributes[:game_server_base_url] + path,
                      :body => body, :headers => { 'Accept' => 'application/json'})
      end
  
      def put(path, body = {})
        #add_auth_token(body)
        HTTParty.put(@attributes[:game_server_base_url] + path,
                     :body => body, :headers => { 'Accept' => 'application/json'})
      end
  
      def get(path, query = {})
        #add_auth_token(query)
        HTTParty.get(@attributes[:game_server_base_url] + path,
                     :query => query, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ token }"})

      end
      
      def add_auth_token(query)
        @auth_token = FiveD::AccessToken.generate_access_token(@attributes[:game_identifier], @attributes[:scopes]) if @auth_token.nil?
        query[:auth_token] = @auth_token.token
      end
  end
end