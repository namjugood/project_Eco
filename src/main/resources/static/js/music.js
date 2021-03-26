var $music = {};

/**
 * data
 */
$music.data = {

	once : 0,

	/* 더보기버튼 */
	more : {
		mseq : 0,
		abseq : 0,
		atseq : 0,
	},

	/* 재생목록 */
	playList : {
		/*	status에 들어갈 값
			nothing // 재생목록에 아무것도없는 상태
			on 		// 재생목록에 하나이상의 노래가 있고, 재생중
			off 	// 재생목록에 하나이상의 노래가 있지만, 재생하지않음
		*/
		status : "nothing",

		// 실행중인 곡 번호
		playingNumber : null,
		
		// 재생목록 정보배열
		items : [
			/* example
			{
				mseq : null,	곡 번호
				title : null,	곡 제목
				src : null,		곡 재생경로
				
				abseq : null,	앨범 번호
				abimg : null,	앨범 재킷
				
				atseq : null,	아티스트 번호
				name : null		아티스트 이름
			}*/
		],
		audio : null, // new Audio
		timer : null, // interval객체
	},

	/* input:checkbox조작시 나타나는 팝업 */
	listByCheck : {
		count : 0,
		items : [],
	},

	/* myList에 들어가기전  */
	myList : {
		items : [
			// {
			// 	mseq: null,
			// }
		]
	}

};

$music.sync = {
	set: function(audioInfo) {
		var audioInfo = audioInfo || {};

		if ($music.data.playList.audio !== null) {
			audioInfo.src = $music.data.playList.audio.src;
			audioInfo.duration = Math.ceil($music.data.playList.audio.duration);
			audioInfo.currentTime = Math.ceil($music.data.playList.audio.currentTime);
			audioInfo.muted = $music.data.playList.audio.muted;
			audioInfo.loop = $music.data.playList.audio.loop;
			audioInfo.volume = $music.data.playList.audio.volume;
			audioInfo.paused = $music.data.playList.audio.paused;
		}

		audioInfo.total = $("#audioBottom").find("#total").text();
		audioInfo.current = $("#audioBottom").find("#current").text();
		audioInfo.gageInner = $("#audioBottom #gage > div").css("width");
		$music.data.playList.audioInfo = audioInfo;
		localStorage.setItem("playList", JSON.stringify($music.data.playList));
	},
	apply: function() {
		var playList = JSON.parse(localStorage.getItem("playList"));

		if (playList) {
			$music.data.playList = playList;

			var audioInfo = playList.audioInfo;
			$music.data.playList.audio = new Audio(playList.audioInfo.src);
			$music.data.playList.audio.duration = audioInfo.duration;
			$music.data.playList.audio.currentTime = audioInfo.currentTime;
			$music.data.playList.audio.muted = audioInfo.muted;
			$music.data.playList.audio.loop = audioInfo.loop;
			$music.data.playList.audio.volume = audioInfo.volume;
			$music.data.playList.audio.paused = audioInfo.paused;

			var item = $music.data.playList.items.filter(function(v) {
				return v.mseq === playList.playingNumber;
			})[0];
	
			var target = $("#audioBottom");
			target.find("#total").text(audioInfo.total);
			target.find("#gage").children().css({
				width: audioInfo.gageInner
			});
			target.find("#current").text(audioInfo.current);

			if ($music.data.playList.audio.loop) {
				$("#audioBottom").find(".loop").css({
					color: "white"
				});
			} else {
				$("#audioBottom").find(".loop").css({
					color: "gray"
				});
			}

			var duration = audioInfo.duration;

			$music.utilMethod.audio.init(item);
			if (audioInfo.paused) {
				$("#audioBottom").find(".play").closest("li").show();
				$("#audioBottom").find(".pause").closest("li").hide();
				if (isNaN($music.data.playList.audio.duration)) {
					$music.sync.set(audioInfo);
				}
			} else {
				$("#audioBottom").find(".pause").closest("li").show();
				$("#audioBottom").find(".play").closest("li").hide();
				$music.method.musicList.play(item.mseq);
			}
		}
	},
}

/**
 * 
 */
$music.utilMethod = {
	/* 목록중 선택한 음악 DOM으로부터 제이쿼리를 통해 필요한 값들을 tr기준으로 검색하여 객체로 반환 */
	getHiddenDataAtTr: function(self) {
		return {
			mseq : self.closest("tr").find("input[name=mseq]").val() * 1
			, abseq : self.closest("tr").find("input[name=abseq]").val() * 1
			, atseq : self.closest("tr").find("input[name=atseq]").val() * 1
			, title : self.closest("tr").find("input[name=title]").val()
			, src : self.closest("tr").find("input[name=src]").val()
			, abimg : self.closest("tr").find("input[name=abimg]").val()
			, name : self.closest("tr").find("input[name=name]").val()
		};
	},

	/* 목록중 선택한 음악 DOM으로부터 제이쿼리를 통해 필요한 값들을 form기준으로 검색하여 객체로 반환 */
	getHiddenDataAtForm: function(self) {
		return {
			mseq : self.closest("form").find("input[name=mseq]").val() * 1
			, abseq : self.closest("form").find("input[name=abseq]").val() * 1
			, atseq : self.closest("form").find("input[name=atseq]").val() * 1
			, title : self.closest("form").find("input[name=title]").val()
			, src : self.closest("form").find("input[name=src]").val()
			, abimg : self.closest("form").find("input[name=abimg]").val()
			, name : self.closest("form").find("input[name=name]").val()
		};
	},
	
	getHiddenDataAtLi: function(self) {
		return {
			mseq : self.closest("li").find("input[name=mseq]").val() * 1
			, abseq : self.closest("li").find("input[name=abseq]").val() * 1
			, atseq : self.closest("li").find("input[name=atseq]").val() * 1
			, title : self.closest("li").find("input[name=title]").val()
			, src : self.closest("li").find("input[name=src]").val()
			, abimg : self.closest("li").find("input[name=abimg]").val()
			, name : self.closest("li").find("input[name=name]").val()
		};
	},

	/* 재생목록 비우기 */
	playListClear: function() {
		$music.data.playList.status = "nothing";
		$music.data.playList.playingNumber = null;
		$music.data.playList.items = [];
	},

	/* 로그인되어있으면 진행 안되어있으면 로그인창 */
	loginCheck : function() {
		if ($("body > input[name=useq]").val() === "") {
			if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
				location.href="/loginForm";
				return false;
			} else {
				return false;
			}
		} else {
			return true;
		}
	},

	onLoading: function() {
		$("#loading").show();
	},

	offLoading: function() {
		$("#loading").hide();
	},

	audio : (function() {

		function next() {
			window.clearInterval($music.data.playList.timer);

			var isNext = (function() {
				var items = $music.data.playList.items;
				var playingNumber = $music.data.playList.playingNumber;

				var endedIndex = items.findIndex(function(v) {
					return v.mseq === (playingNumber*1);
				});

				if (items[endedIndex + 1]) {
					return true;
				} else {
					return false;
				}
			})();

			var target = $("#audioBottom");
			
			// 다음곡 존재
			if (isNext) {
				var endedIndex = $music.data.playList.items.findIndex(function(v) {
					return v.mseq === ($music.data.playList.playingNumber*1);
				});

				var next = $music.data.playList.items[endedIndex + 1];
				$music.data.playList.playingNumber = next.mseq;
				$music.data.playList.audio.src = next.src;
				target.find("#abimg").attr("src", next.abimg);
				target.find("#title").text(next.title);
				target.find("#name").text(next.name);
				target.find("#total").text("00:00");
				target.find("#current").text("00:00");
				target.find("#gage").children().css({
					width: "0%"
				});
				$music.data.playList.audio.play()
				.then(function() {
					init(next, false);
					startInterval();
				});
			}
			// 다음곡 미존재
			else {
				target.find("#current").text("00:00");
				target.find("#gage").children().css({
					width: "0%"
				});
				target.find(".play").closest("li").show();
				target.find(".pause").closest("li").hide();
			}
		};

		var init = function(musicInfo, first) {
			(function bottom() {
				var target = $("#audioBottom");
				$music.data.once++;
				// if ($music.data.once === 1) {
					if (musicInfo) {
						target.find("#abimg").attr("src", musicInfo.abimg).show();
						target.find("#title").text(musicInfo.title);
						target.find("#name").text(musicInfo.name);
						target.find("#mseq").val(musicInfo.mseq);
					}
					
					if ($music.data.playList.audio) {
						if ($music.data.playList.audio.paused && first) {
							target.find(".play").closest("li").show();
							target.find(".pause").closest("li").hide();
						} else {
							target.find(".pause").closest("li").show();
							target.find(".play").closest("li").hide();
						}
					} else {
						target.find(".play").closest("li").show();
						target.find(".pause").closest("li").hide();
					}
		
					$("#audioBottom").show();
					$("footer").css({
						marginBottom: "120px"
					});
		
					var audiomseq = target.find("#mseq").val();
					target.find(".like")
						.css({
							color: "gray",
						})
						.removeClass("likemseq");
					$("#loginUserLikeList").children().each(function(index, el) {
						var likemseq = $(el).val();
						
						if (likemseq === audiomseq) {
							target.find(".like")
							.css({
								color: "red",
							})
							.addClass("likemseq");
						}
					});
				// } else {
				// 	window.setTimeout(function() {
				// 		$music.data.once = 0;
				// 	}, 100);
				// }
			
				
			})();

			$("#audioRight .loading").hide();
			$("#audioRight #title").css({color: 'white'});
			$("#audioRight #name").css({color: 'gray'});
			var target = $("#audioRight").find("#item_" + $music.data.playList.playingNumber);
			if (target) {
				target.find(".loading").show();
				target.find("#title").css({color: "#3f3fff"});
				target.find("#name").css({color: "#3f3fff"});
			}

			$music.sync.set();
			$music.method.audioRight.scroll(musicInfo.mseq);
		};

		function startInterval() {
			var target = $("#audioBottom");
			$music.data.playList.status = "on";
			var total = (function() {
				if ($("input[name=membership]").val() !== "Y") {
					return 60;
				} else {
					return $music.data.playList.audio.duration;
				}
			})();
			var totalMin = Math.ceil(total/60)-1 === 0 ? 1 : Math.ceil(total/60)-1; 
			var totalSec = Math.ceil(total) % 60;
			if (totalMin < 10) totalMin = "0" + totalMin;
			if (totalSec < 10) totalSec = "0" + totalSec;
			target.find("#total").text(totalMin + ":" + totalSec);

			$music.data.playList.timer = window.setInterval(function() {
				var current = $music.data.playList.audio.currentTime;

				target.find("#gage").children().css({
					width: (current / total * 100) + "%"
				});

				var currentMin = (Math.ceil($music.data.playList.audio.currentTime / 60) - 1) > 0 ? Math.ceil($music.data.playList.audio.currentTime / 60) - 1 : 0;
				var currentSec = Math.ceil($music.data.playList.audio.currentTime) % 60;

				if (currentMin < 10) currentMin = "0" + currentMin;
				if (currentSec < 10) currentSec = "0" + currentSec;
				target.find("#current").text(currentMin + ":" + currentSec);

				if ($("input[name=membership]").val() !== "Y") {
					if (($music.data.playList.audio.currentTime >= 60)) {
						$music.data.playList.audio.pause();
						window.clearInterval($music.data.playList.timer);
						next();
					}
				} else {
					// 곡이 끝나면 다음곡 찾아서 재생
					if ($music.data.playList.audio.ended) {
						window.clearInterval($music.data.playList.timer);
						next();
					}
				}

				$music.sync.set();
			}, 1000);
		}
		
		var run = function(playItem, isDiff) {
			$("#audioBottom .icon .play").hide();
			window.clearInterval($music.data.playList.timer);
			$music.method.audioRight.set();
			
			var target = $("#audioBottom");

			if ($music.data.playList.status !== "off") {
				target.find("#total").text("00:00");
				target.find("#current").text("00:00");
				target.find("#gage").children().css({
					width: "0%"
				});
			}
			if ($music.data.playList.audio) {
				if (playItem) {
					if (isDiff) {
						$music.data.playList.audio.src = playItem.src;
					} else if ($music.data.playList.playingNumber !== playItem.mseq) {
						$music.data.playList.audio.src = playItem.src;
					}
				}
			} else  {
				if (playItem && playItem.src) {
					$music.data.playList.audio = new Audio(playItem.src);	
				} else {
					return console.log("음악 정보가 없으므로 재생할 수 없습니다");
				}
			}
			$music.data.playList.audio.play()
			.then(function() {
				init(playItem);
				startInterval();
				$("#audioBottom .icon .play").show();
			})
		};

		var stop = function() {
			if ($music.data.playList.audio) {
				window.clearInterval($music.data.playList.timer);
				$music.data.playList.audio.pause();

				var target = $("#audioBottom");
				target.find(".play").closest("li").show();
				target.find(".pause").closest("li").hide();
			}
		};

		var setLoop = function() {
			if ($music.data.playList.audio) {
				if ($music.data.playList.audio.loop) {
					$("#audioBottom").find(".loop").css({
						color: "white"
					});
				} else {
					$("#audioBottom").find(".loop").css({
						color: "gray"
					});
				}
			}
		}

		return {
			init: init,
			run: run,
			stop: stop,
			setLoop: setLoop,
		}
	})(),
}

/**
 * 함수
 */
$music.method = {
	/* 듣기, 재생목록, 내리스트, 더보기 같은 아이콘의 hover기능 TODO: 모든 아이콘제어는 이걸로 하게되면 색깔 일괄변경 가능 */
	iconHoverListen : (function() {
		$(function() {
			$(".iconButton").mouseover(function() {
				$(this).find("span").css({
					color:"#3f3fff"
					, opacity: 0.5
				});
			});
	
			$(".iconButton").mouseleave(function() {
				if ($(this).hasClass("unlike")) {
					$(this).find("span").css({
						color:"red"
						, opacity: 1
					});
				} else {
					$(this).find("span").css({
						color:"#333333"
						, opacity: 1
					});
				}
				
			});
		});
	})(),

	/* 더보기 버튼 hover 기능 */
	moreHoverListen : (function() {
		$(function() {
			$("#musicMoreBox .textBox").mouseover(function() {
				var index = $(this).closest("li").index();
				if (index === 5) {

				} else {
					$(this).prev().find("span").css({color: "#3f3fff"});
				}
				
				$(this).next().show();
				// $(this).parent().css({background: "#dedede"});
				// $(this).find("a").css({color: "#cb78ff"});
			});
	
			$("#musicMoreBox .textBox").mouseleave(function() {
				var index = $(this).closest("li").index();
				if (index === 5) {
				} else {
					$(this).prev().find("span").css({color: "#333333"});
				}
				
				$(this).next().hide();
				// $(this).parent().css({background: "#ffffff"});
				// $(this).find("a").css({color: "#333333"});
			});

			$("#musicMoreBox .close").mouseover(function() {
				$(this).find("span").css({color: "#3f3fff"});
			});

			$("#musicMoreBox .close").mouseleave(function() {
				$(this).find("span").css({color: "#333333"});
			});
		});
	})(),

	/* 더보기 관련 on/off함수포함한 객체 리턴 */
	more : (function() {

		function initFlag() {
			$music.data.more.mseq = 0;
			$music.data.more.abseq = 0;
			$music.data.more.atseq = 0;
		};
		
		function applyFlag(mseq, abseq, atseq) {
			$music.data.more.mseq = mseq;
			$music.data.more.abseq = abseq;
			$music.data.more.atseq = atseq;
		};
	
		function initAttr() {
			$("#musicMoreBox .textBox").eq(0).find("a").attr("href", "#");
			$("#musicMoreBox .textBox").eq(1).find("a").attr("href", "#");
			$("#musicMoreBox .textBox").eq(2).find("a").attr("href", "#");
			// $("#musicMoreBox .textBox").eq(3).find("a").attr("href", "#");
			// $("#musicMoreBox .textBox").eq(5).find("a").attr("href", "#");
		};
	
		function applyAttr() {
			$("#musicMoreBox .textBox").eq(0).find("a").attr("href", "musicView?mseq=" + $music.data.more.mseq);
			$("#musicMoreBox .textBox").eq(1).find("a").attr("href", "albumView?abseq=" + $music.data.more.abseq);
			$("#musicMoreBox .textBox").eq(2).find("a").attr("href", "artistView?atseq=" + $music.data.more.atseq);
			$("#musicMoreBox .textBox").eq(3).find("a").attr("onclick", "$music.method.like(null, null, "+$music.data.more.mseq+");");
			$("#musicMoreBox .textBox").eq(4).find("a").attr("onclick", "$music.method.unlike(null, null, "+$music.data.more.mseq+");");
			$("#musicMoreBox .textBox").eq(5).find("a").attr("onclick", "$music.method.ban("+$music.data.more.mseq+");");
		};
	
		var off_musicMoreBox = function() {
			$("#musicMoreBox").hide();
			initFlag(); // 플래그 변수 값 초기화
			initAttr(); // 팝업의 경로 속성 초기화
		};
	
		var on_musicMoreBox = function(self) {
			var music = $music.utilMethod.getHiddenDataAtTr(self);
			if (self.closest("tr").find("input[name=likeyn]").length > 0) {
				$("#musicMoreBox .textBox").eq(3).closest("li").hide();
				$("#musicMoreBox .textBox").eq(4).closest("li").show();
			} else {
				$("#musicMoreBox .textBox").eq(3).closest("li").show();
				$("#musicMoreBox .textBox").eq(4).closest("li").hide();
			}

			if ($music.data.more.mseq !== music.mseq) { // 최초 한번 클릭시

				// 스크롤 감지
				$(window).on("scroll", function(){
					/* 팝업 띄워놓고 스크롤하고다니면 이상한거같아서... 지우는게 낫다고 판단 */
					off_musicMoreBox();
				});

				var position = self.closest("td").offset();
				var scrollHeight = $(document).scrollTop();
				$("#musicMoreBox").css({
					left: position.left - 129,
					top: position.top + 86 - scrollHeight,
				});

				// hidden으로부터 읽어온 값 중 플래그값에 고유번호들만 저장
				applyFlag(
					music.mseq
					, music.abseq
					, music.atseq
				); 

				// 저장한 고유값으로 팝업 경로에 적용
				applyAttr();
	
				$("#musicMoreBox").show();
	
			} else { // 동일한 행의 더보기를 또 눌렀을 시
				off_musicMoreBox();
			}
		};

		return {
			on_musicMoreBox: on_musicMoreBox, // 더보기버튼 on
			off_musicMoreBox: off_musicMoreBox, // 더보기버튼 off
		}
	})(),

	/* 음악목록 중 체크 누르면 나오는 팝업 on/off포함 */
	listByCheck : (function() {
		var off_listByCheck = function() {
			$("#listByCheckBox").hide();

			// 초기화
			$music.data.listByCheck.items = [];
			$music.data.listByCheck.count = 0;
		};
	
		var on_listByCheck = function() {

			var musicInfoList = [];
			$("input:checkbox[name=mseq_checkbox]:checked").each(function(index, el) {
				// tr>td>input:checkbox로 시작해 tr로 올라간다음 input:hidden들의 값을 추출
				var music = $music.utilMethod.getHiddenDataAtTr($(el));
				musicInfoList.push(music);
			});

			// 갖고온 musicInfoList를 보관
			$music.data.listByCheck.items = musicInfoList;
			$music.data.listByCheck.count = musicInfoList.length;

			// 띄워질 화면에 적용하고 show
			$("#listByCheckBox").find(".count").text($music.data.listByCheck.count);
			$("#listByCheckBox").show();
		};

		var uncheck = function() {
			// 체크되어있는 값 풀리게 다시 클릭
			$("input:checkbox[name=mseq_checkbox]:checked").each(function(index, el) {
				$(el).trigger("click");
			});
		};

		var listen = function() {
			// 재생목록 초기화
			$music.utilMethod.playListClear();

			// 체크되어있는 값의 tr로 접근해 초기화된 재생목록에 담고 첫건 재생
			$("input:checkbox[name=mseq_checkbox]:checked").each(function(index, el) {
				$(el).closest("tr").find(".playListAdd").trigger("click");
			});

			// 전부 체크해제
			uncheck();
		};

		var playList = function() {
			// 체크되어있는 값의 tr로 접근해 초기화된 재생목록에 담기
			$("input:checkbox[name=mseq_checkbox]:checked").each(function(index, el) {
				$(el).closest("tr").find(".playListAdd").trigger("click");
			});

			// 전부 체크해제
			uncheck();
		};

		return {
			on_listByCheck: on_listByCheck 		// on
			, off_listByCheck: off_listByCheck 	// off
			, uncheck : uncheck					// 선택해제
			, listen : listen					// 듣기
			, playList : playList				// 재생목록
		};
	})(),

	/* 재생목록 기능들을 가진 객체 리턴 */
	musicList : (function() {

		// 중복제거 
		function removeDuplicate() {
			$music.data.playList.items = $music.data.playList.items.filter(function(item, index) {
				return (
					$music.data.playList.items.findIndex(function(findItem) {
						return findItem.mseq === item.mseq;
					}) === index
				);
			});
		};

		function alreadyMusic(music) {
			return $music.data.playList.items.findIndex(function(item) {
				return item.mseq === music.mseq;
			}) > -1;
		};

		function getData() {
			return {
				status : $music.data.playList.status,
				playingNumber : $music.data.playList.playingNumber,
				items : $music.data.playList.items,
			};
		};

		function add(music, isFirst) {
			if (isFirst) {
				$music.data.playList.items.unshift(music); // 기존의 목록의 맨앞에 넣기
			} else {
				$music.data.playList.items.push(music); // 기존의 목록의 맨뒤에 넣기
			}
			removeDuplicate();
		};

		var stop = function() {
			$music.data.playList.status = "off"; // 상태 off로 변경
			$music.utilMethod.audio.stop();
		};

		var play = function(mseq) {

			if (mseq) {
				var isDiff = mseq !== $music.data.playList.playingNumber
				
				$music.data.playList.playingNumber = mseq; 	// 진행중 곡 번호 저장
				$music.data.playList.status = "on"; 		// 상태 on으로 변경
	
				var playItem = $music.data.playList.items.find(function(v){
					return v.mseq === mseq;
				});
			}

			$music.utilMethod.audio.run(playItem, isDiff);
			
		};

		var next = function() {
			var now = getData().items.findIndex(function(music) {
				return music.mseq === getData().playingNumber; // 재생중인 곡번호가 몇번째 인지 반환
			});
			
			// 마지막곡 여부
			var isFinal = now === (getData().items.length - 1);

			// 마지막 곡이었다면
			if (isFinal) {
				alert("다음곡이 없습니다");
				// play(getData().items[0].mseq); // 첫번째 곡으로 재생실행
			} else {
				play(getData().items[now + 1].mseq); // 현재 재생중인 곡의 다음곡으로 재생실행
			}
		};

		var prev = function() {
			var now = getData().items.findIndex(function(music) {
				return music.mseq === getData().playingNumber; // 재생중인 곡번호가 몇번째 인지 반환
			});
			
			// 처음곡 여부
			var isFirst = now === 0;

			// 첫번째 곡이었다면
			if (isFirst) {
				alert("이전곡이 없습니다");
				// play(getData().items[getData().items.length - 1].mseq); // 마지막 곡으로 재생실행
			} else {
				play(getData().items[now-1].mseq); // 현재 재생중인 곡의 이전곡으로 재생실행
			}
		};

		// 듣기 - 목록에서(tr)에서 듣기버튼을 누른경우
		var listen = function(self) {
			// 기존의 재생목록과 재생중인지 아닌지 상관없이 추가하고 바로 재생
			var music = $music.utilMethod.getHiddenDataAtTr(self);

			if (alreadyMusic(music)) {
				console.log("\""+ music.name +"\"의 \"" + music.title + "\"는(은) 이미 존재하는 곡입니다.\n 새로 추가되지않고 바로 재생합니다");
			} else {
				add(music);
			}
			
			play(music.mseq);
		};

		// 한곡 추가 - 목록에서(tr에서) 재생목록담기버튼을 누른경우
		var playListAdd = function(self) {
			// tr로 올라가서 music정보 수집
			var music = $music.utilMethod.getHiddenDataAtTr(self);
			add(music);
			if ($music.data.playList.status === "nothing") {
				$music.utilMethod.audio.init(music);
			}
		};

		// 한곡 추가 - 음악상세에서 재생목록담기버튼을 누른경우
		var playListAddForm = function(self) {
			// tr로 올라가서 music정보 수집
			var music = $music.utilMethod.getHiddenDataAtForm(self);
			add(music);
			if ($music.data.playList.status === "nothing") {
				$music.utilMethod.audio.init(music);
			}
		};
		
		// 전부 추가 - 목록위의 전체듣기 버튼을 누른 경우
		var playListAddAll = function(musicTrList) {
			$music.utilMethod.playListClear(); // 재생목록 비우기

			var musicDataList = [];
			$(musicTrList).each(function(index, item){
				var music = $music.utilMethod.getHiddenDataAtTr($(item));
				musicDataList.push(music);
			});

			for(var i = 0; i < musicDataList.length; i++) {
				var music = musicDataList[i];
				add(music);
			}

			play(musicDataList[0].mseq);
		};
		
		// 전부 추가 - 목록위의 전체듣기 버튼을 누른 경우
		var playListAddAllMain = function(musicLiList) {
			$music.utilMethod.playListClear(); // 재생목록 비우기

			var musicDataList = [];
			$(musicLiList).each(function(index, item){
				var music = $music.utilMethod.getHiddenDataAtLi($(item));
				musicDataList.push(music);
			});

			for(var i = 0; i < musicDataList.length; i++) {
				var music = musicDataList[i];
				add(music);
			}

			play(musicDataList[0].mseq);
		};

		// 전부 추가 - 음악상세의 재생목록버튼아이콘을 누른경우
		var playListAddMusic = function(target) {
			$music.utilMethod.playListClear(); // 재생목록 비우기

			var music = $music.utilMethod.getHiddenDataAtForm(target);
			add(music);
			play(music.mseq);
		};

		// 전부 추가 - 아티스트상세의 앨범목록중 재생목록버튼아이콘을 누른경우
		var playListAddAlbum = function(playListIcon) {
			$music.utilMethod.playListClear(); // 재생목록 비우기

			var musicDataList = [];
			playListIcon.closest(".albumItem").find(".musicInfoByAlbum").each(function(index, item) {
				var music = $music.utilMethod.getHiddenDataAtForm($(item));
				musicDataList.push(music);
			});

			for(var i = 0; i < musicDataList.length; i++) {
				var music = musicDataList[i];
				add(music);
			}

			play(musicDataList[0].mseq);
		};

		return {
			stop : stop
			, play : play
			, next : next
			, prev : prev
			, listen : listen
			, playListAdd : playListAdd
			, playListAddAll : playListAddAll
			, playListAddAlbum : playListAddAlbum
			, playListAddForm : playListAddForm
			, playListAddMusic : playListAddMusic
			, playListAddAllMain : playListAddAllMain
		};
	})(),

	audioRight : (function() {
		var scroll = function(mseq) {
			$music.data.once++;

			// if ($music.data.once === 1) {
				var n = 0;

				try {
					$("#audioRight .list > ul > li").each(function(index, el) {
						var id = $(el).attr("id");
						id = id.split("_")[1];
			
						if ((id * 1) === mseq) {
							n = index;
						}
					});
					$('#audioRight .list').animate({scrollTop : n * 60}, 400);
				} catch(e) {
					console.log("html attr id not found");
				}
			// } else {
			// 	window.setTimeout(function() {
			// 		$music.data.once = 0;
			// 	}, 100);
			// }
			
		};

		var search = function(keyword) {
			$("#audioRight .list > ul > li").css({
				position : "absolute",
				top: "-9999px",
				left: "-9999px",
			});
			$("#audioRight .list > ul > li").find("p:containsIN('"+keyword+"')").closest("li").closest("ul").closest("li").css({
				position : "relative",
				top: "unset",
				left: "unset",
			});
		};

		var set = function() {
			var target = $("#audioRight").find(".list").find("ul");
			target.empty();
			target.find("#title").val("");

			if ($("#audioRight").css("display") === "block") {
				
				var items = "";

				$music.data.playList.items.forEach(function(item) {
					var mseq = item.mseq;
					var title = item.title;
					var src = item.src;
					var abseq = item.abseq;
					var abimg = item.abimg;
					var atseq = item.atseq;
					var name = item.name;
					
					var item = "";
					item += "<li id=\"item_"+mseq+"\">";
					item += "    <input type=\"hidden\" name=\"mseq\" value=\""+mseq+"\">";
					item += "    <input type=\"hidden\" name=\"title\" value=\""+title+"\">";
					item += "    <input type=\"hidden\" name=\"src\" value=\""+src+"\">";
					item += "    <input type=\"hidden\" name=\"abseq\" value=\""+abseq+"\">";
					item += "    <input type=\"hidden\" name=\"abimg\" value=\""+abimg+"\">";
					item += "    <input type=\"hidden\" name=\"atseq\" value=\""+atseq+"\">";
					item += "    <input type=\"hidden\" name=\"name\" value=\""+name+"\">";
					item += "	<ul>";
					item += "		<li style=\"position: relative;\">";
					item += "			<img id=\"abimg\" src=\""+abimg+"\" width=\"40px\" height=\"40px\" style=\"cursor:pointer;\" onclick=\"location.href='albumView?abseq="+abseq+"'\">";
					item += "			<div class=\"loading\" style=\"display:none;cursor:pointer;\" onclick=\"location.href='albumView?abseq="+abseq+"'\">";
					item += "				<img src=\"pageimages/loading.svg\" width=\"26px\" height=\"26px\" style=\"position: absolute;top: 7px;left: 7px;\">";
					item += "			</div>";
					item += "		</li>";
					item += "		<li style=\"margin-left: 10px;cursor:pointer;\">";
					item += "			<p id=\"title\" class=\"singleline-ellipsis\">"+title+"</p>";
					item += "			<p id=\"name\">"+name+"</p>";
					item += "		</li>";
					item += "	</ul>";
					item += "</li>";

					items += item;
				});
				target.append(items);

				// var status = $music.data.playList.status;
				var playingNumber = $music.data.playList.playingNumber;

				if (playingNumber != 0) {
					$("#audioRight .loading").hide();
					$("#audioRight #title").css({color: 'white'});
					$("#audioRight #name").css({color: 'gray'});
					var target = $("#audioRight").find("#item_" + playingNumber);

					target.find(".loading").show();
					target.find("#title").css({color: "#3f3fff"});
					target.find("#name").css({color: "#3f3fff"});

					scroll(playingNumber);
				}

			}
			$music.sync.set();
		};

		return {
			scroll: scroll,
			search: search,
			set: set,
		}
	})(),

	/* 내 리스트 */
	myList: (function() {
		var on = function(el) {
			if ($music.utilMethod.loginCheck()) {
				// 선택자 있으면 단건, 없으면 여러건
				if (el) {
					var music = $music.utilMethod.getHiddenDataAtTr(el);
					$music.data.myList.items = [];
					$music.data.myList.items.push(music);
				}

				$("#myListBox").show();
				$("#dim").show();
			}
		};

		var off = function() {
			$("#myListBox").hide();
			$("#dim").hide();
		};

		// 내리스트 띄우는건 동일하나, 체크박스를 통해 생성된 팝업에서 온경우
		var on_listByCheckBox = function() {
			var musicList = [];

			$("input:checkbox[name=mseq_checkbox]:checked").each(function(index, el) {
				var music = $music.utilMethod.getHiddenDataAtTr($(el));
				musicList.push(music);
			});
			$music.data.myList.items = musicList;
			
			on();
		};

		// 내리스트 띄우는건 동일하나, 앨범상세나 아티스트상세에서 내 리스트에 추가할 경우
		var on_listByDetail = function() {
			var musicTrList = $("#listBox .musicTr");

			var musicList = [];
			$(musicTrList).each(function(index, item){
				var music = $music.utilMethod.getHiddenDataAtTr($(item));
				musicList.push(music);
			});

			$music.data.myList.items = musicList;
			
			on();
		};

		// 내리스트 띄우는건 동일하나, 아티스트상세의 앨범목록을 통해 수록곡들을 추가할 경우
		var on_albumList = function(el) {
			// form의 이름이 "musicByAlbum-" 으로 시작하는 것들 ex) musicByAlbum-1, musicByAlbum-2, musicByAlbum-3, ...
			var musicList = [];
			el.closest(".albumItem").find(".musicInfoByAlbum").each(function(index, item) {
				var music = $music.utilMethod.getHiddenDataAtForm($(item));
				musicList.push(music);
			});

			$music.data.myList.items = musicList;

			on();
		};

		var addBundleMaster = function(el) {
			var parameter = {
				title: el.closest("form").find("input[name=title]").val()
			};

			if (parameter.title.length === 0) {
				alert("제목을 입력하세요");
				return false;
			} else {
				$.ajax({
					url: 'addBundleMaster',
					type: 'POST',
					data: JSON.stringify(parameter),
					contentType: 'application/json',
					dataType: 'json'
				  })
				.done(function(response) {
					// 성공 시 동작
	
					var template = `
						<div class="bundleList">
							<input type="hidden" name="bmseq" value="${response.bmseq}">
							<input type="hidden" name="title" value="${response.title}">
							<ul>
								<li><div><span style="color: white;"><i class="fas fa-music"></i></span></div></li>
								<li><div><ul><li>${response.title}</li><li>0곡</li></ul></div></li>
							</ul>
						</div>
					`;
					$("#myListBoxBundleBox").prepend(template);
				});
				return true;
			}
		};

		var addBundleDetail = function(bundleMaster) {
			var bundleDetailList = [];
			for (var i = 0; i < $music.data.myList.items.length; i++) {
				var bundleDetail = {
					bmseq: bundleMaster.bmseq
					, mseq: $music.data.myList.items[i].mseq
				}
				bundleDetailList.push(bundleDetail);
			}
			$.ajax({
				url: 'addBundleDetail',
				type: 'post',
				data: JSON.stringify(bundleDetailList),
				contentType: 'application/json',
				dataType: 'json'
			  })
			.always(function() {
				location.reload();
			})
		};
		
		return {
			on: on,
			off: off,

			on_listByCheckBox: on_listByCheckBox,
			on_listByDetail: on_listByDetail,

			on_albumList: on_albumList, 

			addBundleMaster: addBundleMaster,
			addBundleDetail: addBundleDetail,
		};
	})(),

	/* 무시하기 */
	ban: function(mseq) {
		if ($music.utilMethod.loginCheck()) {
			console.log('mseq =>', JSON.stringify(mseq, undefined, 2));
			$.ajax({
				url: 'ban',
				type: 'post',
				data: JSON.stringify(mseq),
				contentType: 'application/json',
				dataType: 'json'
			})
			.always(function() {
				location.reload();
			});
		}
	},

	/* 무시하기 취소 */
	unban: function(mseq) {
		if ($music.utilMethod.loginCheck()) {
			console.log('mseq =>', JSON.stringify(mseq, undefined, 2));
			$.ajax({
				url: 'unban',
				type: 'post',
				data: JSON.stringify(mseq),
				contentType: 'application/json',
				dataType: 'json'
			})
			.always(function() {
				location.reload();
			});
		}
	},

	/* 좋아요 */
	like: function(atseq, abseq, mseq) {
		if ($music.utilMethod.loginCheck()) {
			console.log(" atseq : " + atseq);
			console.log(" abseq : " + abseq);
			console.log(" mseq : " + mseq);
			var atseq = atseq && atseq * 1;
			var abseq = abseq && abseq * 1;
			var mseq = mseq && mseq * 1;
			var parameter = {
				atseq : atseq,
				abseq : abseq,
				mseq : mseq,
			};
			$.ajax({
				url: 'like',
				type: 'post',
				data: JSON.stringify(parameter),
				contentType: 'application/json',
				dataType: 'json'
			})
			.always(function() {
				location.reload();
			});
		}
	},

	/* 좋아요 취소 */
	unlike: function(atseq, abseq, mseq) {
		if ($music.utilMethod.loginCheck()) {
			console.log(" atseq : " + atseq);
			console.log(" abseq : " + abseq);
			console.log(" mseq : " + mseq);
			var atseq = atseq && atseq * 1;
			var abseq = abseq && abseq * 1;
			var mseq = mseq && mseq * 1;
			var parameter = {
				atseq : atseq,
				abseq : abseq,
				mseq : mseq,
			};
			$.ajax({
				url: 'unlike',
				type: 'post',
				data: JSON.stringify(parameter),
				contentType: 'application/json',
				dataType: 'json'
			})
			.always(function() {
				location.reload();
			});
		}
	},

	albumViewPlayButton: function() {
		// 앨범상세에서 앨범재킷안에 play버튼을 눌렀을 때
		// 모든 앨범수록곡을 playList에 추가

		// 재생목록 초기화
		$music.utilMethod.playListClear();

		// 앨범수록곡의 모든 tr에 접근해 초기화된 재생목록에 담고 첫건 재생
		$("#listBox .musicTr").each(function(index, el) {
			$(el).closest("tr").find(".listen").trigger("click");
		});

		// 전부 체크해제
		uncheck();
	},
};

/**
 * event
 */

$(function() {

	$.extend($.expr[":"], {
		"containsIN": function(elem, i, match, array) {
		return (elem.textContent || elem.innerText || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
	}});

	$(window)	
		.ajaxStart(function(){
			$music.utilMethod.onLoading();
		})
		.ajaxStop(function(){
			$music.utilMethod.offLoading();
		});



	// 음악관련 어느곳에서 동일사용 (단, html구조와 music.js를 import해주어야 동작.)
	(function all() {

	/* <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;"> */
		// 전체듣기	
		$("#playListAddAll").on("click", function() {
			var musicTrList = $("#listBox .musicTr");
			$music.method.musicList.playListAddAll(musicTrList);
		});
	/* <a class="allListen iconButton" id="playListAddAll" style="cursor: pointer;"> */

	/* <table id="listBox"> */

		// 내 리스트 추가
		$("#listBox .myListAdd").on("click", function() {
			$music.method.myList.on($(this));
		});

		// 재생목록에 추가
		$("#listBox .playListAdd").on("click", function() {
			$music.method.musicList.playListAdd($(this));
		});

		// 듣기 기능 연동시작점 TODO:
		$("#listBox .listen").on("click", function() {
			$music.method.musicList.listen($(this));
		});

		// 더보기 기능 연동시작점
		$("#listBox .moreDiv").on("click", function() {
			$music.method.more.on_musicMoreBox($(this));
		});

		// 체크박스(일괄처리) 클릭시
		$("input:checkbox[name=allCheck]").on("click", function() {
			// allCheck의 체크여부에 따라 모든 체크박스 on/off
			var isAllCheck = $(this).is(":checked");
			$("input:checkbox[name=mseq_checkbox]").each(function() {
				this.checked = isAllCheck;
			});

			if ($("input:checkbox[name=mseq_checkbox]:checked").length > 0) { // 한개라도 선택된게 남아있다면
				$music.method.listByCheck.on_listByCheck();
			} else {
				$music.method.listByCheck.off_listByCheck();
			}
		});

		// 체크박스(단일처리) 클릭시
		$("input:checkbox[name=mseq_checkbox]").on("click", function() {
			var justTotalCount = $("input:checkbox[name=mseq_checkbox]").length;       // 전체개수
			var checkedCount = $("input:checkbox[name=mseq_checkbox]:checked").length; // 선택개수

			$("input[name=allCheck]:checkbox").prop("checked", (justTotalCount === checkedCount)); // 일괄처리버튼 적용

			if ($("input:checkbox[name=mseq_checkbox]:checked").length > 0) { // 한개라도 선택된게 남아있다면
				$music.method.listByCheck.on_listByCheck();
			} else {
				$music.method.listByCheck.off_listByCheck();
			}
		});
	/* <table id="listBox"> */

	/* <div id="listByCheckBox" style="display:none;"> */
		// listByCheckBox의 버튼 이벤트 1. 선택해제
		$("#listByCheckBox .uncheck").on("click", function() {
			$music.method.listByCheck.uncheck();
		});

		// listByCheckBox의 버튼 이벤트 2. 듣기
		$("#listByCheckBox .listen").on("click", function() {
			$music.method.listByCheck.listen();
			$music.method.musicList.play($music.data.playList.items[0].mseq);
		});

		// listByCheckBox의 버튼 이벤트 3. 재생목록담기
		$("#listByCheckBox .playList").on("click", function() {
			$music.method.listByCheck.playList();
		});

		// listByCheckBox의 버튼 이벤트 4. 내 리스트
		$("#listByCheckBox .myList").on("click", function() {
			$music.method.myList.on_listByCheckBox();
			$music.method.listByCheck.off_listByCheck();
		});
	/* <div id="listByCheckBox" style="display:none;"> */

	/* <div id="myListBox" style="display:none;"> */
	$(document).on("click", ".bundleList", function() {
		var bundleMaster = {
			bmseq : $(this).find("input[name=bmseq]").val()
			, title : $(this).find("input[name=title]").val()
		};

		$music.method.myList.addBundleDetail(bundleMaster);
	});

	$("form[name=addBundleMaster]").on("click", "input[type=button]", function() {
		if ($music.method.myList.addBundleMaster($(this))) {
			$(this).closest('.form').hide();
			$(this).closest('.form').prev().show();
		}
	});

	$("form[name=addBundleMaster]").on("click", "input[type=reset]", function() {
		$(this).closest('.form').hide();
		$(this).closest('.form').prev().show();
	});

	/* <div id="myListBox" style="display:none;"> */

	/* <li class="albumItem"> */

	// 아티스트상세의 앨범목록 중 재생목록 추가하기
	$("#music_artistView .albumItem .playListAdd").on("click", function() {
		$music.method.musicList.playListAddAlbum($(this));
	});

	// 아티스트상세의 앨범목록 중 내리스트 추가하기
	$("#music_artistView .albumItem .myListAdd").on("click", function() {
		$music.method.myList.on_albumList($(this));
	});

	/* <li class="albumItem"> */

	/* artistView, albumView, musicView  */

	// 아티스트
	if ($("#music_artistView").length > 0) {
		if ($("input[name=artistlikeyn]").length > 0) {
			$(".artist .info .like").remove();
		} else {
			$(".artist .info .unlike").remove();
		}

		$("#music_artistView .albumItem").each(function(index, el) {
			if ($(el).find("input[name=albumlikeyn]").length > 0) {
				$(el).find(".album .info .like").remove();
			} else {
				$(el).find(".album .info .unlike").remove();
			}
		});
	}
	// 앨범
	else if ($("#music_albumView").length > 0) {
		if ($("input[name=albumlikeyn]").length > 0) {
			$(".album .info .like").remove();
		} else {
			$(".album .info .unlike").remove();
		}
	}
	// 음악
	else if ($("#music_musicView").length > 0) {

		if ($("input[name=musiclikeyn]").length > 0) {
			$(".music .info .like").remove();
		} else {
			$(".music .info .unlike").remove();
		}

		// ban
		if ($("input[name=musicbanyn]").length > 0) {
			$(".music .info .ban").remove();
		} else {
			$(".music .info .unban").remove();
		}
	}

	$("#infoAndTrack li").on("click", function() {
		$(this).siblings().removeClass("selectTab");
		$(this).addClass("selectTab");

		var index = $(this).index();
		if (index === 0) {
			$("#infoBox").show();
			$("#trackBox").hide();
		} else {
			$("#infoBox").hide()
			$("#trackBox").show();
		}

		$("body").scrollTop(0);
	});

	/* albumView, artistView */

	/* audioBottom */
	$("#audioBottom")
		.find(".icon").on("click", function() {
			if ($(this).hasClass("loop")) {
				if ($music.data.playList.audio.loop) {
					$music.data.playList.audio.loop = false;
				} else {
					$music.data.playList.audio.loop = true;
				}

				$music.utilMethod.audio.setLoop();
			}

			if ($(this).hasClass("prev")) {
				$music.method.musicList.prev();
			}

			if ($(this).hasClass("play")) {
				var mseq = null;

				if ($music.data.playList.playingNumber) {
					$music.method.musicList.play($music.data.playList.playingNumber);	
				} else {
					mseq = $music.data.playList.items[0].mseq;
					$music.method.musicList.play(mseq);
				}
			}

			if ($(this).hasClass("pause")) {
				$music.method.musicList.stop();
			}

			if ($(this).hasClass("next")) {
				$music.method.musicList.next();
			}

			if ($(this).hasClass("shuffle")) {
				$music.data.playList.items = $music.data.playList.items.map(a => ([Math.random(),a]))
					.sort((a,b) => a[0]-b[0])
					.map(a => a[1]);

				$music.method.audioRight.set();
			}

			if ($(this).hasClass("like")) {
				if ($(this).hasClass("likemseq")) {
					// 좋아요 취소 호출
					$music.method.unlike(null, null, $("#audioBottom").find("#mseq").val());
				} else {
					// 좋아요 호출
					$music.method.like(null, null, $("#audioBottom").find("#mseq").val());
				}
			}

			if ($(this).hasClass("volume")) {

			}

			if ($(this).hasClass("list")) {
				$("#audioRight").fadeToggle('fast', function() {
					$music.method.audioRight.set();
				});
				
			}

			$music.sync.set();
		});
	$("#audioBottom .icon")
		.mouseover(function() {
			$(this).css({
				opacity: 0.2
			});
		})
		.mouseleave(function() {
			$(this).css({
				opacity: 1
			});
		});
	$("#audioBottom")
		.find("#gage").on("click", function(e) {

			var total = (function() {
				if ($("input[name=membership]").val() !== "Y") {
					return 60;
				}
				else {
					return $music.data.playList.audio.duration;
				}
			})()

			// at page
			var xAtPage = e.pageX; // 전체중 x축 좌표
			var leftAtPage = $(this).offset().left; // x축 범위 중 최소값 = 페이지내부에서의 왼쪽 기준 위치값
			var rightAtPage = $(this).offset().left + $(this).width(); // x축 범위 중 최대값 = 페이지내부에서의 위치값 + 넓이(width)

			// at gage
			var rangeAtGage = rightAtPage - leftAtPage; // 전체에서 gage만의 범위
			var xAtGage = xAtPage - leftAtPage; // gage만의 범위와 비교한 값

			// 필요없는 부분을 뺀 순수 gage만의 영역에서 몇퍼센트지점을 클릭했나
			var percentage = xAtGage / rangeAtGage * 100;

			// 어디서부터 시작
			var where = Math.ceil(total * percentage / 100);

			// 현재재생시간을 선택한 시점으로
			$music.data.playList.audio.currentTime = where;

			// 시간 계산해서 화면 적용
			var target = $("#audioBottom");
			var totalMin = Math.ceil(total/60)-1 === 0 ? 1 : Math.ceil(total/60)-1; 
			var totalSec = Math.ceil(total) % 60;
			if (totalMin < 10) totalMin = "0" + totalMin;
			if (totalSec < 10) totalSec = "0" + totalSec;
			target.find("#total").text(totalMin + ":" + totalSec);

			var current = $music.data.playList.audio.currentTime;

			target.find("#gage").children().css({
				width: (current / total * 100) + "%"
			});

			var currentMin = (Math.ceil($music.data.playList.audio.currentTime / 60) - 1) > 0 ? Math.ceil($music.data.playList.audio.currentTime / 60) - 1 : 0;
			var currentSec = Math.ceil($music.data.playList.audio.currentTime) % 60;

			if (currentMin < 10) currentMin = "0" + currentMin;
			if (currentSec < 10) currentSec = "0" + currentSec;
			target.find("#current").text(currentMin + ":" + currentSec);
		});

		$("#audioRight .closeAudioRight").on("click", function() {
			$("#audioRight").toggle();
			$("#audioRight").find(".list").find("ul").empty();
		});

		$("#audioRight .closeText").on("click", function() {
			document.audioRightSearch.title.value = '';
		});

		$(document).on("click", "#audioRight #title, #audioRight #name", function() {
			var id = $(this).closest("ul").closest("li").attr("id");
			id = id.split("_")[1];

			var mseq = id * 1;

			if ($music.data.playList.playingNumber === mseq) {
				if ($music.data.playList.status === "on") {
					$("#audioBottom").find(".pause").trigger("click");
				} else if ($music.data.playList.status === "off") {
					$("#audioBottom").find(".play").trigger("click");
				}
			} else {
				$music.method.musicList.play(mseq);
			}

			$music.method.audioRight.scroll(mseq);
		});

		$("#audioRight #clear").mouseover(function() {
			$(this).css({
				color: "red"
			});
		}).mouseleave(function() {
			$(this).css({
				color: "white"
			})
		});

		$("#audioRight #clear").click(function() {
			if(confirm("재생목록을 비우시겠습니까?")) {
				localStorage.removeItem("playList");
				if ($music.data.playList.audio) {
					$music.data.playList.audio.pause();
				}
				window.clearInterval($music.data.playList.timer);
				$music.data.playList = {
					status : "nothing",
					playingNumber : null,
					items : [],
					audio : null,
					timer : null,
				};

				$("#audioRight").animate({opacity: 0}, 1000, function() {
					$(this).hide();
					$(this).css({opacity: 1});
					$("#audioRight .list ul").empty();
				});

				$("#audioBottom").animate({opacity: 0}, 1000, function() {
					$("#audioBottom").find("#abimg").hide().attr("src", "");
					$("#audioBottom").find("#title").text("");
					$("#audioBottom").find("#name").text("");
					$("#audioBottom").find("#current").text("00:00");
					$("#audioBottom").find("#total").text("00:00");
					$(this).hide();
					$(this).css({opacity: 1});
				});

				$("footer").css({
					marginBottom: "20px"
				});
			}
		})

		if ($("body > input[name=useq]").val() === "") {
			$("#audioBottom").find(".like").remove();
		}
	/* audioBottom */

	})();

	$music.sync.apply();
});