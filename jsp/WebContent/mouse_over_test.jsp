<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>


<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <title>ShowBigImg</title>

    <script src="../js/jquery-1.3.2-vsdoc2.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(document).ready(function () {

            // 모든 이미지 파일의 이미지명을 얻어 bigs 폴더에 있는 동일한 이미지를 div태그에 출력

            $('#product img').mouseover(function () {

                $('#showImage').show();                                         // 이미지를 보여줄 레이어 보이기

                var imgSrc = "";                                                // 이미지 소스 저장 변수 설정

                imgSrc = "<img src= "+ './logo/aladin.jpg' + "/>";   // 큰 이미지로 설정하기

                $("#showImage").html(imgSrc);                                   // 레이어에 HTML 추가하기

            });

            $('#product img').mouseout(function () {

                $("#showImage").hide();

            });

        });

    </script>

</head>

<body>

    <div id="product">

        <img src="https://thumbs.dreamstime.com/z/champion-gold-silver-bronze-medal-template-red-ribbon-icon-sign-first-second-third-place-transparent-background-105725323.jpg" />

    </div>

    <div id="showImage" style="border:1px soild red; width:400px; height:400px;">

    </div>

</body>

</html>