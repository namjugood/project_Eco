<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
    #audioBottom {
        user-select: none;
        position: fixed;
        bottom: 0;
        left: 0;
        z-index: 100;
        background: black;
        width: 100%;
        height: 100px;
        margin: 0;
        padding: 0;
    }
    #audioBottom * {
        /* border: 1px solid red; */
        margin: 0;
        padding: 0;
        list-style-type: none;
    }
    #audioBottom > ul {
        position: relative;
        margin: 0 auto;
        width: 950px;
        display: flex;
        justify-content: center;
    }
    #audioBottom > ul > li {
        position: relative;
        display: inline-block;
        height: 100px;
    }

    #audioBottom .right > ul > li > ul {
        position: absolute;
        width: 200px;
        right: 0px;
        top: 24px;
    }

    #audioBottom .right > ul > li {
        position: relative;
        display: inline-block;
        margin-left: 20px;
    }

    #audioBottom .center {
        position: relative;

    }

    #audioBottom #controller {
        font-size: 7px;
        color: #333333;
    }

    #audioBottom #controller ul {
        width: 100%;
        margin: 0 auto;
        position: relative;
        display: flex;
        justify-content: space-around;
    }
    #audioBottom #controller ul li {
        display: inline-block;
        position: relative;
    }
    #audioBottom #controller ul:nth-of-type(2) li:nth-of-type(2) {
        width: 260px;
    }
    
    #audioBottom #controller #gage {
        position: absolute;
        top: 12px;
        left: 0px;
        width: 100%;
        height: 4px;
        border-radius: 5px;
        background: #333333;
        cursor: pointer;
    }
    
    #audioBottom #controller #gage > div{
        height: 100%;
        width: 0%;
        background: #3f3fff;
        border-radius: 5px;
    }

    #audioBottom #noti {
        position: absolute;
        top: -15px;
        left: 0px;
        color: white;
        font-size: 8px;
        font-weight: 100;
        width: 100%;
        background-color: rgba(0, 0, 0, 0.9);
        margin: 0 auto;
    }

    #audioBottom #noti {
        text-align: center;
        font-size: 10px;
        color: gray;
    }

    #audioBottom #noti small {
        color: white;
    }

    #audioBottom #current, #audioBottom #total {
        line-height: 27px;font-size: 7px;
        color: lightgray;
    }
</style>
<style>
        #audioRight {
            user-select: none;
            position: fixed;
            right: 0;
            top: 0;
            width: 260px;
            height: calc(100% - 140px);
            background: #222222;
            z-index: 9999;
            padding: 30px;
            padding-top: 10px;
        }

        #audioRight * {
            /* border: 1px solid red; */
            /* color: white; */
        }

        #audioRight > div {
            height: 100%;
            width: 100%;
            margin: 0 auto;
            padding: 0;
        }

        #audioRight .list {
            position: relative;
            width: 100%;
            background-color: black;
            border-radius: 10px;
            margin-top: 20px;
            margin-bottom: 20px;
            color: white;
            height: calc(100vh - 244px);
            overflow-y: scroll;
        }

        #audioRight .list::-webkit-scrollbar {
            width: 10px;
        }
        #audioRight .list::-webkit-scrollbar-thumb {
            background-color: gray;
            border-radius: 10px;
            background-clip: padding-box;
            border: 2px solid transparent;
        }
        #audioRight .list::-webkit-scrollbar-track {
            background-color: black;
            border-radius: 10px;
            /* box-shadow: inset 0px 0px 5px black; */
        }

        #audioRight .list * {
            list-style: none;
            margin: 0;
            padding: 0;
            font-weight: 100;
        }

        #audioRight .list > ul > li {
            width: calc(100% - 20px);
            height: 40px;
            padding: 10px;
        }

        #audioRight .list > ul > li > ul {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            position: relative;
        }

        #audioRight .list > ul > li > ul > li {
            display: inline-block;
        }

        #audioRight .loading {
            position: absolute;
            top: 0px;
            left: 0px;
            background-color: rgba(0, 0, 0, 0.9);
            width: 40px;
            height: 40px;
        }

        #audioRight #title {
            font-size: 11px;
            position: absolute;
            top: 1px;
            width: 170px;
        }

        #audioRight #name {
            font-size: 8px;
            position: absolute;
            top: 20px;
            color: gray;
        }
</style>

<form style="position: absolute;width: 0;height: 0;" id="loginUserLikeList">
    <c:forEach var="likeMseq" items="${loginUser.likeList}" varStatus="status">
        <input type="hidden" name="likeMusicByLoginUser" value="${likeMseq}">
    </c:forEach>
</form>

<div id="audioBottom" style="display:none;">
    <input id="mseq" type="hidden" name="mseq" value="">
    <c:if test="${membership ne 'Y'}">
        <div id="noti">
            <p>멤버십 회원이 아니므로 재생시간은 <small>1분</small> 입니다.</p>
        </div>    
    </c:if>
    <ul>
        <li style="width:300px;margin-top: 10px;height: 80px;">
            <img id="abimg" style="position: absolute;top: 10px;" src="" onerror="this.style.display='none';" width="63px" height="63px">
            <p id="title" style="position: absolute;left: 80px;top: 20px;font-size: 12px;color: white;"></p>
            <p id="name" style="position: absolute;left: 80px;top: 48px;color: gray;font-size: 7px;"></p>
        </li>
        <li id="controller" style="width:340px;" class="center">
            <ul style="margin-top:20px;">
                <li style="margin-top: 10px;"><span class="icon loop" style="cursor:pointer;font-size: 14px; color: gray;"><i class="fas fa-retweet"></i></span></li>
                <li style="margin-top: 5px;"><span class="icon prev" style="cursor:pointer;font-size: 20px; color: white;"><i class="fas fa-step-backward"></i></span></li>
                <li><span class="icon play" style="cursor:pointer;font-size: 24px; color: white;"><i class="fas fa-play"></i></span></li>
                <li style="display:none;"><span class="icon pause" style="cursor:pointer;font-size: 24px; color: white;"><i class="fas fa-pause"></i></span></li>
                <li style="margin-top: 5px;"><span class="icon next" style="cursor:pointer;font-size: 20px; color: white;"><i class="fas fa-step-forward"></i></span></li>
                <li style="margin-top: 10px;"><span class="icon shuffle" style="cursor:pointer;font-size: 14px; color: gray;"><i class="fas fa-random"></i></span></li>
            </ul>
            <ul style="margin-top:10px;">
                <li id="current">00:00</li>
                <li>
                    <div id="gage">
                        <div></div>
                    </div>
                </li>
                <li id="total">00:00</li>
            </ul>
        </li>
        <li style="width:300px;" class="right">
            <ul style="position: absolute;right: 40px;top: 35px;">
                <li>
                    <span class="icon like" style="cursor:pointer;font-size: 20px; color: gray;"><i class="far fa-heart"></i></span>
                </li>
                <li>
                    <span class="icon volume" style="cursor:pointer;font-size: 20px; color: gray;"><i class="fas fa-volume-up"></i></span>
                </li>
                <li>
                    <span class="icon list" style="cursor:pointer;font-size: 20px; color: gray;"><i class="fas fa-list-ul"></i></span>
                </li>
            </ul>
        </li>
    </ul>
</div>

<div id="audioRight" style="display:none;">
    <div>
        <h2 style="font-size: 20px;position: relative;color: white;">
            재생목록
            <span id="clear" style="cursor: pointer;position: absolute;top: 6px;left: 82px;color: white;font-size: 11px;opacity: 1;"><i class="fas fa-trash-alt"></i></span>
            <div class="closeAudioRight" style="position: absolute;right: 0;top: -2px;cursor: pointer;">
                <span style="color: white;">
                    <i class="fas fa-times"></i>
                </span>
            </div>
        </h2>
    
        <div class="form">
            <form name="audioRightSearch" onsubmit="return false">
                <div class="textBox" style="position: relative;">
                    <span style="position: absolute;top: 8px;left: 9px;font-size: 13px;font-weight: 100;color: gray;">
                        <i class="fas fa-search"></i>
                    </span>
                    <input type="text" name="title" value="" placeholder="재생목록에서 검색해주세요." autocomplete="off" onkeyup="$music.method.audioRight.search($(this).val());"
                        style="width: 230px;height: 34px;padding-left: 26px;border-radius: 22px;background-color: #333333;border: 0;font-size: 12px;color: #fff;">
                    <a class="closeText" style="cursor: pointer;position: absolute;top: 0px;right: 35px;">
                        <span style="cursor: pointer;position: absolute;top: 4px;right: -16px;color:gray;">
                            <i class="fas fa-times"></i>
                        </span>
                    </a>
                </div>
            </form>
            <div class="list">
                <ul>
                    <li>
                        <ul>
                            <li style="position: relative;">
                                <img id="abimg" src="https://cdn.music-flo.com/image/album/206/823/02/04/402823206_5cf3eb30.jpg?1559489315548/dims/resize/500x500/quality/90" width="40px" height="40px">
                                <div class="loading" style="display:none;">
                                    <img src="pageimages/loading.svg" width="26px" height="26px" style="position: absolute;top: 7px;left: 7px;">
                                </div>
                            </li>
                            <li style="margin-left: 10px;">
                                <p id="title" style="font-size: 15px;position: absolute;top: 1px;">Unkiss Me</p>
                                <p id="name" style="font-size: 12px;position: absolute;top: 20px;color: gray;">Maroon 5</p>
                            </li>
                            <li>
                                <span style="cursor: pointer;position: absolute;top: 7px;right: 41px;color: gray;font-size: 16px;"><i class="fas fa-folder-plus"></i></span>
                                <span style="cursor: pointer;position: absolute;top: 7px;right: 12px;color: gray;font-size: 16px;"><i class="fas fa-ellipsis-v"></i></span>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>