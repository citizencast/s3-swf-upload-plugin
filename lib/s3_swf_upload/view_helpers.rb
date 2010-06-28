module S3SwfUpload
  
  class I18NMessages
    def [](key)
      I18n.t(key, :scope => 's3_swf_upload.messages')
    end
    
    def all
      all_messages = {}
      I18n.available_locales.each do |locale|
        all_messages[locale] = I18n.all_translations[locale][:s3_swf_upload][:messages]
      end
      all_messages
    end
    
  end
  
  ERROR_MESSAGES = I18NMessages.new
  
  module ViewHelpers
    def s3_swf_upload_tag(options = {})
      height          = options[:height] || 50
      width           = options[:width]  || 420
      success         = options[:success]  || ''
      failed          = options[:failed]  || ''
      selected        = options[:selected]  || ''
      canceled        = options[:canceled] || ''
      prefix          = options[:prefix] || 's3_swf/'
      destinationKey  = options[:destinationKey] || ''
      fileTypes       = options[:fileTypes] || "*.mov; *.flv; *.wmv; *.avi; *.mp4; *.mpg; *.m4v; *.mod; *.divx; *.vob; *.3gp; *.mpeg; *.mbv; *.asf; *.f4v;"
      fileTypeDesc    = options[:fileTypeDesc] || 'Video files'
      start           = options[:start] || ''
      maxSize         = options[:maxSize] || '400000000'
      
      @include_s3_upload ||= false
      @count ||= 1
      
      out = ""
      out << %(
        <div id="s3_swf#{@count}">
          #{ERROR_MESSAGES[:update_flash]}
        </div>
      )
      
      if !@include_s3_upload
        out << javascript_include_tag("s3_upload.js")
        @include_s3_upload = true
      end

      out << %(<script type="text/javascript">
            var s3_swf#{@count} = s3_swf_init('s3_swf#{@count}', {
              fileTypes: '#{fileTypes}',
              fileTypeDesc: '#{fileTypeDesc}',
              width:  #{width},
              height: #{height},
              locales: #{ERROR_MESSAGES.all[I18n.locale.to_sym].to_json},
              onSuccess: function(filename, filesize){
                #{success}
              },
              onStart: function(filename, filesize){
                #{start}
              },
              onFailed: function(status){
                #{failed}
              },
              onFileSelected: function(filename, size){
                #{selected}
              },
              onCancel: function(){
                #{canceled}
              }
            });
            
        </script>

        <a href="#" id='s3_upload_#{@count}' onclick="s3_swf#{@count}.upload('#{prefix}', '#{destinationKey}');">#{ERROR_MESSAGES[:send]}</a>
        
        <script type="text/javascript">
          if (swfobject.hasFlashPlayerVersion("10.0.0") == false) {
            $('#s3_upload_#{@count}').hide();
          }
        </script>
        
      )
      
      @count += 1
      out
    end
  end
end

ActionView::Base.send(:include, S3SwfUpload::ViewHelpers)