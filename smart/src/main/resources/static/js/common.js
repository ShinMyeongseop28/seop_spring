/**
 * 공통처리함수
 */
"use strict"

$(function(){
	var today = new Date();
	var range = today.getFullYear()-100 + ":" + today.getFullYear(); //년도선택범위
	
	$.datepicker.setDefaults({
		dateFormat: "yy-mm-dd",
		changeYear: true,
		changeMonth: true,
		showMonthAfterYear: true,
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월",
						 "7월", "8월", "9월", "10월", "11월", "12월" ],
	 	dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		maxDate: today,	 //최대선택가능날짜	
		yearRange: range,				 
	})
	
	$(".date").attr("readonly", true); //날짜 입력불가(달력선택만가능)
	$(".date").datepicker();
	
	$(".date").on("change", function(){
		$(this).next(".date-remove").removeClass("d-none")
	})
	
	// 단일파일 선택 처리
	$(".file-single").on("change", function(){
		// console.log( $(this) )
		console.log( 'attached> ', this.files[0] )
		
		var preview = $(this).closest(".file-info").find(".file-preview")
		var remove = $(this).closest(".file-info").find(".file-remove");
		
		var attached = this.files[0];
		if ( attached ){ //선택한 파일이 있는 경우
			// 파일크기 제한하는 경우
			if( fileSizeOver(attached, $(this)) ) return;
			
			remove.removeClass("d-none") // 삭제버튼 보이게
			
			// 이미지만 첨부해야 하는 경우
			if( $(this).hasClass("image-only") ){
				//실제 선택한 파일이 이미지인 경우
				if( attached.type.includes("image") ){
					// console.log("이미지O")
					singleFile = attached; // 선택한 파일정보 담기
					
					preview.html( "<img>" )
					
					// 선택한 파일정보를 읽어서 img태그의 src로 지정
					var reader = new FileReader();
					reader.readAsDataURL( attached );
					reader.onload = function(){
						preview.children("img").attr("src", this.result)
					}
					
				}else{ // 선택파일이 이미지가 아닌 경우
					// console.log("이미지X")
					alert("이미지만 선택할 수 있습니다")
					setFileInfo( $(this) );				}
				
			}else{ //모든 파일 첨부가능한 경우
				singleFile = attached; // 선택한 파일정보 담기
				
			}
			
		}else{ // 선택파일 없는 경우(undefined)
			setFileInfo( $(this) )
		}
		console.log("파일> ", $(this).val())
	})
	
	// 파일삭제 클릭시 선택한 파일정보 삭제
	$(".file-info .file-remove").on("click", function(){
		singleFile = "";
		setFileInfo( $(this) )
	})
	
	$(".date + .date-remove").on("click", function(){
		$(this).prev(".date").val("");
	})
});

var singleFile = ""; // 파일정보를 담을 변수

// 잘못 선택시 이전선택 파일정보가 유지되게
function setFileInfo( tag ){
	var info = tag.closest(".file-info");
	if( singleFile != ""){
		// 파일데이터를 전송하는 처리
		var transfer = new DataTransfer();
		transfer.items.add( singleFile )
		info.find(".file-single").prop("files", transfer.files)
		console.log( tag.val() )
	}else{
		// 선택한 파일정보 삭제
		info.find( ".file-single" ).val("");
		info.find( ".file-remove" ).addClass("d-none") // 삭제버튼 안보이게
		
		// 프로필은 기본이미지로 지정
		var preview = info.find(".file-preview")
		if( preview.hasClass("profile") ){
			preview.html( `<i class="font-profile fa-solid fa-user-secret"></i>` )
		}
	}
	console.log( "파일태그값> ", tag.val() )
}

$(document).on("click",".date + .date-remove", function(){
	//폰트이미지가 동적으로 만들어지므로 문서에 이벤트 등록
	$(this).addClass("d-none").prev(".date").val("");
})

// 파일크기 제한하기
function fileSizeOver(file, tag){
	// 1K=1024b, 1M=1024*1024b, 1G=1024*1024*1024b
	if( file.size > 1024*1024*10 ){ // 10M
		alert("10MB를 넘는 파일은 첨부할 수 없습니다")
		setFileInfo( tag )
		return true;
	} else {
		return false;
	}
}

//우편번호 주소찾기 처리
function findPost( post, address1, address2 ){
	new daum.Postcode({
		oncomplete: function(data) {
			console.log(data)
			post.val(data.zonecode)
			var address = data.userSelectedType == "R" ? data.roadAddress : data.jibunAddress
			if (data.buildingName != "") address += " (" + data.buildingName + ")"
			address1.val(address)
			address2.val("")
		}
	}).open();
}




