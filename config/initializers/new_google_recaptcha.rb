if Object.const_defined?('NewGoogleRecaptcha')
  NewGoogleRecaptcha.setup do |config|

    config.site_key = ""
    config.secret_key = ""

    
    config.minimum_score = 0.5
  end
end
