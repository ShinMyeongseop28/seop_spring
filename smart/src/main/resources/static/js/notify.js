/**
 * STOMP 관련
 */

const stompClient = new StompJs.Client({
    brokerURL: socketURL
});

$(function(){
	
	stompClient.activate();
	stompClient.onConnect = (frame) => {
	    console.log('Connected: ' + frame);
	    stompClient.subscribe('/topic/notify', (notify) => { // 수신
			// console.log( 'subscribe notify>', JSON.parse(notify.body) );
	        showNotify( JSON.parse(notify.body) );
	    });
		publishNotify(); // 송신
	};
	
	// 미확인 댓글수 알림 보여주기
	function showNotify( notify ){
		console.log( 'show notify> ', notify )
		// 자신의 것만 표시하게
		if( authID != notify.userid ) return;
		
		if( notify.comments == 0 ){
			$("#notify-count").removeClass("notify-on").empty()
			$(".comment-fade").remove()
		} else {
			$("#notify-count").addClass("notify-on").text( notify.comments )
						
			// 현재 사용자접속 화면이 방명록 목록인 경우 실시간으로 해당 글에 달린 미확인댓글 존재 표시하기
			// console.log("href> ", window.location.href )
			if( window.location.href.includes("/board/list") ){
				// 미확인 댓글 존재시 깜빡임 표시
				// 미확인 댓글 없을시 깜빡임 삭제
				var td = $(`td[data-id=${notify.board_id}]`);
				if( notify.notifycnt==0 ){
					td.find(".comment-fade").remove()
				} else {
					if( td.find(".comment-fade").length==0 ){
						td.append(`<i class="comment-fade text-danger fa-solid fa-comment-dots fa-bounce"></i>`)
					}
				}
			}
		}
			
	}
	
	stompClient.onWebSocketError = (error) => {
	    console.error('Error with websocket', error);
	};
	
	stompClient.onStompError = (frame) => {
	    console.error('Broker reported error: ' + frame.headers['message']);
	    console.error('Additional details: ' + frame.body);
	};
	
//	function showGreeting(message) {
//	    $("#greetings").append("<tr><td>" + message + "</td></tr>");
//		console.log( message )
//	}
	
//	function sendName() {
//	    stompClient.publish({
//	        destination: "/smart/app/hello",
//	        body: JSON.stringify({'name': $("#name").val()})
//	    });
//	}
	
//	$("#name").on("keyup", function(e){
//		if( e.keyCode==13 ) sendName()
//	})

//$("#notify").on("hide.bs.dropdown", function(){
//	// 외부 클릭시 드랍다운닫기 + 댓글목록도 삭제하기
//	$("#dropdown-list").empty()
//})

$("#notify").on( {
	"hide.bs.dropdown": function(){
		// 외부 클릭시 드랍다운닫기 + 댓글목록도 삭제하기
		$("#dropdown-list").empty()
	},
	"click": function(){
		// 인증된 사용자의 미확인 댓글 목록이 보여지게 한 후 읽음(확인)처리
		if( $("#notify-count").text() != ""){
			$.ajax( {
				url: notifyURL
			}).done(function(response){
				$("#dropdown-list").html( response )
				
				publishNotify() // 미확인댓글의 변경사항 발생을 송신하기
			})
			
		} else {
			$("#dropdown-list").removeClass("show")
		}
	}
})
})

// 메시지 송신처리: 로그인유저의 미확인 댓글수를 조회하도록 사용자id를 보내기
function publishNotify( info ) {
	stompClient.publish({
		destination: context + "/app/notify",
		body: JSON.stringify( info==undefined ? { userid: authID } : info )
	});
}
