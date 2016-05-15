# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
   # config.use_s3 = true		
   # config.s3_bucket = 'expressmobileproducts'		
   # config.s3_access_key = "AKIAJLMAISGBIX4SDW3A"		
   # config.s3_secret = "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"
   Spree.config do |config|
   #S3 configuration
      if Rails.env.production? then
           #production. Store images on S3.
           # development will default to local storage
          attachment_config = {
          s3_credentials: {
            access_key_id: 'AKIAJLMAISGBIX4SDW3A',
            secret_access_key:'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' ,
            bucket: 'expressmobileproducts',
          },


          storage:        :s3,
          s3_headers:     { "Cache-Control" => "max-age=31557600" },
          s3_protocol:    "https",
          bucket:        'expressmobileproducts',

          path:          ":rails_root/public/:class/:attachment/:id/:style/:basename.:extension",
          default_url:   "/:class/:attachment/:id/:style/:basename.:extension",
          default_style: "product",
          }

          attachment_config.each do |key, value|
               Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
          end
     end
end

Spree.user_class = "Spree::LegacyUser"
