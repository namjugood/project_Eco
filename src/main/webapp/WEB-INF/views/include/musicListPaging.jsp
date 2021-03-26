<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style type="text/css">
        body {
            text-align: center;
        }

        #paging {
            font-size: 150%;
        }
    </style>
</head>

<body>
    <div id="musicListMore">
        <c:if test="${param.displayRow lt param.totalCount}">
            <div>
                <a href="${action}?page=${index}">
                    더보기
                </a>
            </div>
        </c:if>
    </div>
</body>

</html>