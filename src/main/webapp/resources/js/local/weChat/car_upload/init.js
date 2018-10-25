/**
 * Created by Cheng Wang on 2016/11/24.
 */
var	contextPath;
//var imgBase64;
//var imgBase64Handle = 0;
$(function() {
    contextPath = $("#contextPath").val();
    $("#carNum").carNumBoard();
    //if(!window.FormData){
    //    $("body").alertDialog({
    //        title: "提示",
    //        text: "你的浏览器不支持html5"
    //    });
    //}
    if ( typeof(FileReader) === 'undefined' ){
        $("body").alertDialog({
            title: "提示",
            text: "你的浏览器不支持html5"
        });
    }
})

function selectUploadImg(){
    preImg('upload_img', 'upload_img_button');
}

function submit(){
    var file = $("#upload_img").get(0);
    if(file.files.length > 0){
        var name = file.files[0].name;
        name = name.substring(name.length - 3, name.length);
        if (name != 'png' && name != 'PNG' && name != 'jpg'
            && name != 'JPG' && name != 'jpeg' && name != 'JPEG'){
            $("body").alertDialog({
                title: "提示",
                text: "只能上传png或jpg图片"
            });
            return
        }
        if(file.files[0].size > 4 * 1024 * 1024){
            $("body").alertDialog({
                title: "提示",
                text: "图片大小不能超过4M"
            });
            return;
        }
    } else {
        $("body").alertDialog({
            title: "提示",
            text: "请选择图片"
        });
        return;
    }
    var carNum = $.trim($("#carNum").html());
    if (carNum == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入车牌号"
        });
        return;
    }
    if (!(carNum.match("^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9_港_澳]{5}$") || carNum.match("^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9_港_澳]{6}$"))) {
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的车牌号"
        });
        return;
    }
    var engineNo = $.trim($("#engineNo").val());
    if (engineNo == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入发动机号"
        });
        return;
    }
    if (engineNo.length > 100){
        $("body").alertDialog({
            title: "提示",
            text: "发动机号长度过长"
        });
        return;
    }

    //if (imgBase64Handle == 0){
    //    $("body").alertDialog({
    //        title: "提示",
    //        text: "图片压缩处理中，请稍后点击‘马上验证’"
    //    });
    //    return;
    //}

    $('body').showLoadingView();
    var imgBase64 = getBase64Image($('#upload_img_button').get(0));
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/car/upload/submit",
        data: {carNum : carNum, openid : getCookie('openid'), engineNo : engineNo, imgBase64 : imgBase64, imgName : file.files[0].name},
        success: function(result) {
            if (result.resCode == '000000') {
                window.location.href = contextPath + "/weixin/car/upload/success";
            } else {
                $("body").hiddenLoadingView();
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }
        }
    });

    //var formData = new FormData($("#uploadForm")[0]);
    //$.ajax({
    //    url: contextPath + "/weixin/car/upload/submit?openid=" + getCookie('openid') + "&carNum=" + carNum + "&engineNo=" + engineNo,
    //    type: 'POST',
    //    data: formData,
    //    async: false,
    //    cache: false,
    //    contentType: false,
    //    processData: false,
    //    success: function (result) {
    //        if (result.resCode == '000000') {
    //            window.location.href = contextPath + "/weixin/car/upload/success";
    //        } else {
    //            $("body").hiddenLoadingView();
    //            $("body").alertDialog({
    //                title: "提示",
    //                text: result.resMsg
    //            });
    //        }
    //    }
    //});
}

function getBase64Image(img) {
    var img_this=new Image();
    img_this.src = $(img).attr('src');
    var width = img_this.width;
    var height = img_this.height;
    var scale = height / width;
    width1 = 1000;
    height1 = parseInt(width1 * scale);
    var canvas = $("#cans");

    canvas[0].width = width1; canvas[0].height = height1;
    var ctx = canvas[0].getContext('2d');
    ctx.drawImage(img_this, 0, 0, width, height, 0, 0, width1, height1);


    var dataURL =canvas[0].toDataURL("image/jpeg");
    return dataURL.replace("data:image/jpeg;base64,", "");

    //var canvas = document.createElement("canvas");
    //canvas.width = img.width;
    //canvas.height = img.height;
    //
    //var ctx = canvas.getContext("2d");
    //ctx.drawImage(img, 0, 0, img.width, img.height);
    //
    //var dataURL = canvas.toDataURL("image/jpeg");
    //return dataURL.replace("data:image/jpeg;base64,", "");

    //var reader = new FileReader();
    //reader.readAsDataURL(img.files[0]);
    //reader.onloadend = function () {
    //    imgBase64 = reader.result.replace("data:image/png;base64,", "").
    //    replace("data:image/jpg;base64,", "").replace("data:image/jpeg;base64,", "");
    //    imgBase64Handle = 1;
    //}
}