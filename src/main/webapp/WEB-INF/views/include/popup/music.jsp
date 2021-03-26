<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 뮤직에서 더보기버튼 눌렀을때 나오는 상자 -->
	<ul id="musicMoreBox" style="display:none;">
        <div class="close" onclick="$music.method.more.off_musicMoreBox();">
            <span style="color: #333333;">
                <i class="fas fa-times"></i>
            </span>
        </div>
        <li>
            <div class="imgBox"><span style="font-size: 14px; color: #333333;"><i class="fas fa-music"></i></span></div>
            <div class="textBox"><a href="#">곡정보</a></div>
            <!-- <div class="checkImgBox"><span style="font-size: 14px; color: #cb78ff;"><i class="fas fa-check"></i></span></div> -->
        </li>
        <li>
            <div class="imgBox"><span style="font-size: 14px; color: #333333;"><i class="fas fa-bullseye"></i></span></div>
            <div class="textBox"><a href="#">앨범정보</a></div>
            <!-- <div class="checkImgBox"><span style="font-size: 14px; color: #cb78ff;"><i class="fas fa-check"></i></span></div> -->
        </li>
        <li>
            <div class="imgBox"><span style="font-size: 14px; color: #333333;"><i class="fas fa-microphone"></i></span></div>
            <div class="textBox"><a href="#">아티스트정보</a></div>
            <!-- <div class="checkImgBox"><span style="font-size: 14px; color: #cb78ff;"><i class="fas fa-check"></i></span></div> -->
        </li>
        <li>
            <div class="imgBox"><span style="font-size: 14px; color: #333333;"><i class="far fa-heart"></i></span></div>
            <div class="textBox"><a>좋아요</a></div>
            <!-- <div class="checkImgBox"><span style="font-size: 14px; color: #cb78ff;"><i class="fas fa-check"></i></span></div> -->
        </li>
        <li>
            <div class="imgBox"><span style="font-size: 14px; color: red;"><i class="far fa-heart"></i></span></div>
            <div class="textBox"><a>좋아요</a></div>
            <!-- <div class="checkImgBox"><span style="font-size: 14px; color: #cb78ff;"><i class="fas fa-check"></i></span></div> -->
        </li>
        <li>
            <div class="imgBox"><span style="font-size: 14px; color: #333333;"><i class="fas fa-ban"></i></span></div>
            <div class="textBox"><a>이 곡 안듣기</a></div>
            <!-- <div class="checkImgBox"><span style="font-size: 14px; color: #cb78ff;"><i class="fas fa-check"></i></span></div> -->
        </li>
    </ul>

<!-- 목록에서 체크박스 선택했을경우 나오는 상자 -->
    <div id="listByCheckBox" style="display:none;">
        <div class="count">
            1
        </div>
        <div>
            <div>
                <ul class="iconList">
                    <li class="uncheck">
                        <span><i class="fas fa-check"></i></span>
                    </li>
                    <li class="listen">
                        <span><i class="fas fa-play"></i></span>
                    </li>
                    <li class="playList">
                        <span><i class="fas fa-outdent"></i></span>
                    </li>
                    <li class="myList">
                        <span><i class="fas fa-folder-plus"></i></span>
                    </li>
                </ul>
                
                <ul class="labelList">
                    <li class="uncheck">선택해제</li>
                    <li class="listen">듣기</li>
                    <li class="playList">재생목록</li>
                    <li class="myList">내 리스트</li>
                </ul>
            </div>
        </div>
    </div>

<!-- 내 리스트 관련 상자 -->
    <div id="myListBox" style="display:none;">
        <div class="close" onclick="$music.method.myList.off();">
            <span style="color: white;">
                <i class="fas fa-times"></i>
            </span>
        </div>
        <div>
            <h2>내 리스트에 담기</h2>
            
            <div>
                <div class="beforeForm" onclick="$(this).next().show();$(this).hide();">
                    <ul>
                        <li>
                            <div>
                                <span style="color: #3f3fff;">
                                    <i class="fas fa-plus"></i>
                                </span>
                            </div>
                        </li>
                        <li>
                            <div style="color: #3f3fff;">
                                새로운 리스트 추가하기
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="form" style="display:none;">
                    <form action="addBundleMaster" method="POST" name="addBundleMaster">
                        <div class="textBox">
                            <input type="text" name="title" class="inputText" placeholder="내 리스트 이름을 입력해주세요">
                        </div>
                        <input class="btn" type="button" value="확인" style="color: #3f3fff;">
                        <input class="btn" type="reset" value="취소">
                        <a class="close" onclick="document.addBundleMaster.title.value='';">
                            <span style="color: #333333;">
                                <i class="fas fa-times"></i>
                            </span>
                        </a>
                        <c:if test="${message}">
                            <p>${message}</p>
                        </c:if>
                    </form>
                </div>
            </div>

            <div id="myListBoxBundleBox">
                <c:forEach var="bundle" items="${bundleList}" varStatus="status">
                    <div class="bundleList">
                        <input type="hidden" name="bmseq" value="${bundle.bmseq}">
                        <input type="hidden" name="title" value="${bundle.title}">
                        <ul>
                            <li>
                                <div>
                                    <c:choose>
                                        <c:when test="${bundle.musicList.size() eq 0}">
                                            <span style="color: white;">
                                                <i class="fas fa-music"></i>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${bundle.musicList.get(0).abimg}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <ul>
                                        <li>${bundle.title}</li>
                                        <li>${bundle.musicList.size()} 곡</li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div id="dim" style="display: none;"></div>

    <div id="loading" style="display:none;">
        <img src="pageimages/loading.svg">
    </div>
