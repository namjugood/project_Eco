<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
    // 서버단의 validator와 상호작용하는 스크립트
    // 해당 클래스 : com.eco.util.MultiToObject
    var errors = [];
    $(function() {
        <c:if test="${not empty errors}">
            <c:forEach var="error" items="${errors}">
                errors.push({"${error.field}" : "${error.defaultMessage}"});
            </c:forEach>    
        </c:if>

        if (errors.length > 0) {
            try {
                for (var i = 0; i < errors.length; i++) {
            	
                    var key = Object.keys(errors[i])[0];
                    
                    if ($("[name=" + key + "]")) {
                        var oldStyle = {
                            border : $("[name=" + key + "]").css("border"),
                            boxShadow : $("[name=" + key + "]").css("box-shadow"),
                        };
                        var errorStyle = {
                            border: "1px solid red",
                            boxShadow: "0px 0px 3px red",
                        };

                        $("[name=" + key + "]")
                            .css(errorStyle)
                            .on("change", function() {$("[name=" + $(this).attr("name") + "]").css(oldStyle);})
                            .attr("placeholder", errors[i][key]);
                    } else {
                        console.log(key + " : " + errors[i][key]);
                    }
                }
            } catch (e) {
                console.log("validator.jsp의 script에서 에러가 납니다. input값을 확인해주세요");
            }
        }
    });
</script>