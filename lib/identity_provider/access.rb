require 'five_d/access_token'
require 'httparty'

module IdentityProvider

  class Access
    
    def initialize(attributes = {})
      @attributes = attributes
    end

    def fetch_identity(identifier)
      get('/identities/' + identifier)
    end
  
    def fetch_identity_properties(identifier)
      get('/identities/'  + identifier + '/character_properties')
    end
    
    def fetch_signup_gift(identifier, client_identifier)
      get('/identities/'  + identifier + "/signup_gifts?client_id=#{client_identifier}")
    end
    
    def deliver_gift_received_notification(identity, resource_gifts)
      subject = "Wir haben Dir Deine Bonus-Startressourcen gutgeschrieben!"        
      body    = "Wir haben Dir als Start-Bonus die folgenden Extra-Ressourcen gutgeschrieben:\n\n"
                
      resource_gifts.each do |resource_gift|
        resource_type = GameRules::Rules.the_rules().resource_types[resource_gift['resource_type_id'].to_i]
        body += "  #{resource_type[:name][:de_DE]}: #{resource_gift['amount']}\n"
      end
                      
      body   += "\nViel Spass mit Wack-A-Doo!\n\nDein Wack-A-Doo Team"

      notification = {
        recipient_id:             identity.identifier,
        recipient_character_name: identity.name,
        sender_id:                nil,
        subject:                  subject,
        body:                     body,
      }
      post("/identities/#{identity.identifier}/messages", { :message => notification })
    end
    
    def create_character_property(identifier, data_object)
      post('/identities/' + identifier + '/character_properties', {:resource_character_property => {:data => data_object}})
    end
    
    def change_character_property(identifier, data_object)
      put('/resource/character_properties/' + identifier, {:resource_character_property => {:data => data_object}})
    end
    
    def change_character_passwort(identifier, password)
      put('/identities/' + identifier, {:identity => {:password => password, :password_confirmation => password}})
    end
    
    def change_character_name(identifier, name)
      put('/identities/' + identifier, {:identity => {:nickname => name}})
    end


    def deliver_attack_notification(recipient, attacked_army, attacker)
      subject = "Du wirst von #{attacker.name} in Wack-a-Doo angegriffen!"        
      body    = "Deine Armee #{attacked_army.name} mit #{attacked_army.size_present} Einheiten wird "+
                 "in der Region #{attacked_army.region.name} von #{attacker.name}"+
                 "#{ attacker.alliance_id.nil? ? "" : " | " + attacker.alliance_tag} angegriffen. "+
                 "\n\nLog Dich jetzt unter https://wack-a-doo.de ein, um auf den Angriff zu reagieren."

      notification = {
        recipient_id:             recipient.identifier,
        recipient_character_name: recipient.name,
        sender_id:                nil,
        subject:                  subject,
        body:                     body,
      }
      post("/identities/#{recipient.identifier}/messages", { :message => notification })
    end
    
    
    def deliver_message_notification(recipient, sender, message)
      subject = if sender.nil?
        "Du hast soeben eine Nachricht in Wack-a-Doo erhalten."
      else
        "Du hast soeben eine Nachricht von #{sender.name} in Wack-a-Doo erhalten."        
      end
      body = if recipient.platinum_account?
        "Betreff: #{message.subject}\n\n"+ 
        " #{ message.body } " +  # : CGI::escapeHTML(message.body) } " +  # since we escape user emails before entering to the database, it seems like we do not need to escape here
        "\n<br/>\nLog Dich jetzt unter https://wack-a-doo.de ein, um auf die Nachricht zu antworten."        
      else
        "Betreff: #{message.subject}\n\n Log Dich jetzt unter https://wack-a-doo.de ein, um die ganze Nachricht zu lesen."
      end
      
      notification = {
        recipient_id:             recipient.identifier,
        recipient_character_name: recipient.name,
        sender_id:                sender.nil? ? nil : sender.identifier,
        sender_character_name:    sender.nil? ? nil : sender.name,
        subject:                  subject,
        body:                     body,
      }
      post("/identities/#{recipient.identifier}/messages", { :message => notification })
    end
    
    def deliver_retention_mail(mail)
      notification = {
        recipient_id:             mail.character.identifier,
        recipient_character_name: mail.character.name,
        subject:                  mail.subject,
        body:                     mail.body,
      }
      post("/identities/#{mail.character.identifier}/messages", { :message => notification })
    end

    def post_result(character, round_number, round_name, won = false)
      round_info = Fundamental::RoundInfo.the_round_info
      return if character.ranking.nil?
      resource_result = {
        round_number:    round_number,
        round_name:      round_name,
        individual_rank: character.ranking.overall_rank,
        character_name:  character.name,
        won:             won,
      }
      unless character.alliance.nil?
        resource_result[:alliance_tag]  = character.alliance.tag
        resource_result[:alliance_name] = character.alliance.name
        resource_result[:alliance_rank] = character.alliance.ranking.overall_rank
        resource_result[:won]           = character.alliance == round_info.winner_alliance
      end
      post('/identities/' + character.identifier + '/results', {:resource_result => resource_result})
    end

    def fetch_history_events(identifier)
      get('/identities/'  + identifier + '/histories')
    end
    
    def post_character_history_event(identifier, data_object, description)
      return if identifier.nil?
      resource_history = {
        data:                  data_object,
        localized_description: description,
      }
      post('/identities/' + identifier + '/histories', {:resource_history => resource_history})
    end

    def post_winner_alliance_history_event(winner_identifiers, data_object, description)
      return if winner_identifiers.blank?
      resource_history = {
        data:                  data_object,
        localized_description: description,
      }
      winner_identifiers.each do |identifier|
        post("/identities/#{identifier}/histories", {:resource_history => resource_history})
      end
    end

    def post_winner_alliance_character_property(winner_identifiers, property)
      return if winner_identifiers.blank?
      resource_character_property = {
        data: property,
      }
      winner_identifiers.each do |identifier|
        post("/identities/#{identifier}/character_properties", {:resource_character_property => resource_character_property})
      end
    end

    protected
      
      def post(path, body = {})
        add_auth_token(body)
        HTTParty.post(@attributes[:identity_provider_base_url] + path,
                      :body => body, :headers => { 'Accept' => 'application/json'})
      end
  
      def put(path, body = {})
        add_auth_token(body)
        HTTParty.put(@attributes[:identity_provider_base_url] + path,
                     :body => body, :headers => { 'Accept' => 'application/json'})
      end
  
      def get(path, query = {})
        add_auth_token(query)
        HTTParty.get(@attributes[:identity_provider_base_url] + path,
                     :query => query, :headers => { 'Accept' => 'application/json'})
      end
      
      def add_auth_token(query)
        @auth_token = FiveD::AccessToken.generate_access_token(@attributes[:game_identifier], @attributes[:scopes]) if @auth_token.nil?
        query[:auth_token] = @auth_token.token
      end
  end
end