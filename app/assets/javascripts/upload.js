$(function(){
    $('#file_form').ajaxForm({
        dataType:'json',
        beforeSubmit: function(){
            var type = $("input[name='file']").val().split('.').pop();
            var type_list = ['jpg','jpeg','gif','png','ico','avi','wma','rmvb','rm','flash','mp4','mid','3gp'];
            if(type == ''){
                alert('请选择文件');
                $('#tip').text('');
                return false
            }
            if($.inArray(type, type_list)==-1){
                alert(' 文件格式错误，请重新上传！');
                $('#tip').text('');
                return false
            }
            $('#tip').text("文件上传中，请耐心等待...");
        },
        success: function(data){
            if(data['message']== 'success'){
                window.location.reload();
            }
        }
    })
});