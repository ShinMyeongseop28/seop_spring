/**
 *  구조동물 관련
 */

// 시도 조회
function animalSido(){
	$.ajax({
		url: "animal/sido"
	}).done(function( response ){
		$(".animal-top").html( response )
	})
}

// 구조동물 조회
function animalList( page, size ){
	// 시도조회
	if( $("#sido").length==0 ) animalSido();
	
	var animal = {};
	animal.sido = $("#sido").length==0 ? "" : $("#sido").val(); // 시도
	animal.sigungu = $("#sigungu").length==0 ? "" : $("#sigungu").val(); // 시군구
	
	$(".loading").removeClass("d-none")
	$.ajax({
		url: `animal/list/${page}/${size}`,
		data: JSON.stringify( animal ),
		type: 'post',
		contentType: 'application/json' 
		// data: { pageNo: page, listSize: size }
	}).done(function( response ){
		$("#data-list").html( response )
		$(".loading").addClass("d-none")
	})
}

// 시군구 조회
function animalSigungu(){
	$("#sigungu").remove()
	if( $("#sido").val()=="" ) return;
	$.ajax({
		url: "animal/sigungu",
		data: { sido: $("#sido").val() }
	}).done(function(response){
		$("#sido").after( response )
	})
}

// 보호소 조회
function animalShelter(){
	$("#shelter").remove()
	if( $("#sigungu").val()=="" ) return;
	
	$.ajax({
		url: "animal/shelter",
		data: { sido: $("#sido").val(), sigungu: $("#sigungu").val() }
	}).done(function( response ){
		$("#sigungu").after( response )
	})
}

$(document).on("click", "img.popfile", function(){
	var pop = $(this).data("popfile")
	$("#modal .modal-body").html( `<img src="${pop}">`)
	$("#modal img").addClass("w-100")
	new bootstrap.Modal( $("#modal") ).show()
})
.on("change", "#sido", function(){
	animalSigungu(); // 시군구 조회
	animalList( 1, $("#listSize option:selected").val() )
})
.on("change", "#sigungu", function(){
	animalShelter();
	animalList( 1, $("#listSize option:selected").val() )
})





