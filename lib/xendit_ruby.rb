XENDIT_BASE_URL = 'https://api.xendit.co/';

module XenditRuby
    class << self
        attr_accessor :api_key
        attr_writer :base_url

        def base_url
            @base_url ||= XENDIT_BASE_URL
        end
    end
end