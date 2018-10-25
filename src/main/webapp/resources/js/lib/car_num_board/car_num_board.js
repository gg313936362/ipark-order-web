/**
 * Created by wangcheng on 2016/5/26.
 */
(function($){
    $.fn.carNumBoard = function (params) {

        this.each(function(){
            var _this = $(this);
            if (_this.html() == ''){
                _this.html("真实车牌号");
            }
            $("body").append("<div class=\"board_div\"></div>");
            $(".board_div").append("<div class=\"board_first_div\"></div>");
            $(".board_div").append("<div class=\"board_second_div\"></div>");
            $(".board_first_div").append("<div class=\"board_first_line board_line\"></div>");
            var htmlContent = new Array("京","津","冀","鲁","晋","蒙","辽","吉","黑","沪");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_first_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_first_div").append("<div class=\"board_sec_line board_line\"></div>");
            var htmlContent = new Array("苏","浙","皖","闽","赣","豫","鄂","湘","粤","桂");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_sec_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_first_div").append("<div class=\"board_third_line board_line\"></div>");
            var htmlContent = new Array("渝","川","贵","云","藏","陕","甘","青");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_third_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_first_div").append("<div class=\"board_fourth_line board_line\"></div>");
            var htmlContent = new Array("琼","新","港","澳","台","宁");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_fourth_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            //第二页
            $(".board_second_div").append("<div class=\"board_fifth_line board_line\"></div>");
            var htmlContent = new Array("1","2","3","4","5","6","7","8","9","0");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_fifth_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_second_div").append("<div class=\"board_sixth_line board_line\"></div>");
            var htmlContent = new Array("港","Q","W","E","R","T","Y","U","P","澳");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_sixth_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_second_div").append("<div class=\"board_seventh_line board_line\"></div>");
            var htmlContent = new Array("A","S","D","F","G","H","J","K","L");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_seventh_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_second_div").append("<div class=\"board_eighth_line board_line\"></div>");
            var htmlContent = new Array("Z","X","C","V","B","N","M");
            for (var i = 0; i < htmlContent.length; i++){
                $(".board_eighth_line").append("<div class=\"board_first_block\">" + htmlContent[i] + "</div>");
            }
            $(".board_eighth_line").append("<div class=\"board_clean\"></div>");

            $(".board_first_block").bind("touchstart", function(){
                if (_this.html().length == 0 || _this.html() == "真实车牌号"){
                    _this.html($(this).html());
                    $(".board_second_div").css("display", "block");
                    $(".board_first_div").css("display", "none");
                } else if(_this.html().length < 8) {
                    _this.html(_this.html() + $(this).html());
                }
            });

            $(".board_clean").bind("touchstart", function(){
                _this.html(_this.html().substring(0, _this.html().length - 1));
                if (_this.html().length == 0){
                    _this.html("真实车牌号");
                    $(".board_first_div").css("display", "block");
                    $(".board_second_div").css("display", "none");
                }
            });

            _this.bind("touchend", function(){
                $("input").blur();
                $(".board_div").css("display", "block");
                if (_this.html().length == 0 || _this.html() == "真实车牌号"){
                    $(".board_first_div").css("display", "block");
                    $(".board_second_div").css("display", "none");
                } else if(_this.html().length > 1) {
                    $(".board_second_div").css("display", "block");
                    $(".board_first_div").css("display", "none");
                }
                var distance = $(window).height() - _this.offset().top - $(".board_div").height() - _this.height();
                if (distance < 0){
                    $("body").css("margin-top", distance + "px");
                }
            });

            $(document).bind("touchstart", function(e){
                e = e || window.event;
                if (e.target.className.indexOf('board') < 0 && e.target != _this.get(0)){
                    $(".board_div").css("display", "none");
                    $("body").css("margin-top", "0px");
                }
            });
        });
    }
})(jQuery);