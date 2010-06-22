module S3SwfUpload
  module ViewHelpers
    def s3_swf_upload_tag(options = {})
      height          = options[:height] || 40
      width           = options[:width]  || 500
      success         = options[:success]  || ''
      failed          = options[:failed]  || ''
      selected        = options[:selected]  || ''
      canceled        = options[:canceled] || ''
      prefix          = options[:prefix] || 's3_swf/'
      destinationKey  = options[:destinationKey] || ''
      fileTypes       = options[:fileTypes] || "*.mov; *.flv; *.wmv; *.avi; *.mp4; *.mpg; *.m4v; *.mod; *.divx; *.vob; *.3gp; *.mpeg; *.mbv; *.asf; *.f4v;"
      fileTypeDesc    = options[:fileTypeDesc] || 'Video files'
      start           = options[:start] || ''
      
      @include_s3_upload ||= false
      @count ||= 1
      
      out = ""
      out << %(
        <div id="s3_swf#{@count}">
          Please <a href="http://www.adobe.com/go/getflashplayer">Update</a> your Flash Player to Flash v9.0.1 or higher...
        </div>
      )
      
      if !@include_s3_upload
        out << '<script type="text/javascript" src="/javascripts/s3_upload.js"></script>' 
        @include_s3_upload = true
      end

      out << %(<script type="text/javascript">
            var s3_swf#{@count} = s3_swf_init('s3_swf#{@count}', {
              fileTypes: '#{fileTypes}',
              fileTypeDesc: '#{fileTypeDesc}',
              width:  #{width},
              height: #{height},
              onSuccess: function(){
                #{success}
              },
              onStart: function(filename){
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

        <a href="#" id='s3_upload_#{@count}' onclick="s3_swf#{@count}.upload('#{prefix}', '#{destinationKey}'); $('#s3_upload_#{@count}').remove();">Upload</a>
      )
      
      @count += 1
      out
    end
  end
end

ActionView::Base.send(:include, S3SwfUpload::ViewHelpers)