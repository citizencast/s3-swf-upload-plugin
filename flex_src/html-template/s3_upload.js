var s3_swf = {
    obj: function() {
        return document["s3_upload"];
    },
    init: function() {
        this.obj().init("http://localhost:3000/s3_signatures", "", "", "", "");
    },
    upload: function(prefix_path) {
        this.obj().upload(prefix_path);
    },
    onSuccess: function() {
    },
    onFailed: function() {
    },
    onSelected: function(fileName, fileSize) {
    },
    onCancel: function() {
    },
    fileTypes: '*.mov; *.flv; *.wmv; *.avi; *.mp4; *.mpg; *.m4v; *.mod; *.divx; *.vob; *.3gp; *.mpeg; *.mbv; *.asf; *.f4v;',
    fileTypeDesc: 'Video files',
    locales: '{"click_to_browse":"Click on the button to browse","uploading":"Uploading","upload_error":"Uploading error","browse":"Browse","upload_finish":"Upload succeed","send":"Upload"}'
}