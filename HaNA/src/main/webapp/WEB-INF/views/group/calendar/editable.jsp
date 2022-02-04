<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="external-events-container-container">
			<div class="external-events-container">
				  <div id='external-events'>

				    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
				      <div class='fc-event-main title'>이벤트 생성 후 드래그</div>
				    </div>
				    <div>
				    	<textarea placeholder="이벤트 제목 입력.." id="eventTitleInput"></textarea>
				    	<button id="createEventButton" onclick="createEventTitle();">이벤트 생성</button>
				    </div>
				
				    <!-- <p>
				      <input type='checkbox' id='drop-remove' />
				      <label for='drop-remove'>remove after drop</label>
				    </p> -->
				  </div>
				  <div class="calendarSaveBtnContainer">
				  	<span style="font-weight:bold; color:gray;">캘린더</span>
				  	<button onclick="saveButton();" class="calendarSave">저장</button>
				  	<button onclick="deleteEvent();" class="calendarSave">삭제</button>
				</div>
			</div>
		</div>
	  <div id='calendar-container'>
	     <div id='calendar'></div>
	  </div>

<%
	String groupId = request.getParameter("groupId");
	pageContext.setAttribute("groupId",groupId);
%>
<script>

let calendar;
let allEvents;
let currentTitle;
var events_data;


	//ajax POST 요청 csrf
	var csrfToken = $("meta[name='_csrf']").attr("content");
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "delete" || options['type'].toLowerCase() === "put") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	  });
	
	
	function getEventsData(){
		let d;
		$.ajax({
			url:"${pageContext.request.contextPath}/group/getCalendarData/${groupId}",
			success(data){
				d = data;
				console.log(d);
				events_data = data;
			},
			error:console.log
		})
		return d;
	}
	console.log(events_data);
	
	document.addEventListener('DOMContentLoaded', function() {
		  var Calendar = FullCalendar.Calendar;
		  var Draggable = FullCalendar.Draggable;
	
		  var containerEl = document.getElementById('external-events');
		  var calendarEl = document.getElementById('calendar');
	/* 	  var checkbox = document.getElementById('drop-remove');
	 */
		  // initialize the external events
		  // -----------------------------------------------------------------
		
	  
		  new Draggable(containerEl, {
		    itemSelector: '.fc-event',
		    eventData: function(eventEl) {
		      return {
		        title: eventEl.innerText
		      };
		    }
	
		  });
	
		  // initialize the calendar
		  // -----------------------------------------------------------------
	
		  calendar = new Calendar(calendarEl, {
			locale:'ko',
		    headerToolbar: {
		      left: 'prev,next today',
		      center: 'title',
		      right: 'dayGridMonth,timeGridWeek,timeGridDay'
		    },
		    events:events_data,
		    editable: true,
		    droppable: true, // this allows things to be dropped onto the calendar
		    /* drop: function(info) {
		      // is the "remove after drop" checkbox checked?
		      if (checkbox.checked) {
		        // if so, remove the element from the "Draggable Events" list
		        info.draggedEl.parentNode.removeChild(info.draggedEl);
		      }
		    }, */
		  });
		  
		 
		  calendar.render();
	/* 	$("#calendar-container").click((e)=>{
			$(e.target).append("<span class='closeon'>X</span>");
			console.log("aslkdjf");
			$(e.target).find(".closeon").click(function() {
		       $('#calendar').fullCalendar('removeEvents',$(e.target));
		    });
		}); */
	});
	
	// 저장버튼 눌렀을 때
	function saveButton(){
		allEvents = calendar.getEvents();
		console.log(allEvents);
		
		let events = new Array();
		for(let i=0; i < allEvents.length; i++){
			let obj = new Object();
			
			obj.title = allEvents[i]._def.title; // 타이틀
			obj.allday = allEvents[i]._def.allDay; // 하루종일인지
			obj.start = allEvents[i]._instance.range.start; // 시작날짜 및 시간
			obj.end = allEvents[i]._instance.range.end; // 종료날짜 및 시간
			
		 	events.push(obj); // 이벤트 정보를 json문자열 형태로 변환
		}
		
		const jsonString = JSON.stringify(events);
		console.log(jsonString);
		
		saveCalendarData(jsonString);
	}
	
	function saveCalendarData(data){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/group/saveCalendarData",
			method:"POST",
			contentType: 'application/json',
			data:data,
			success(data){
				console.log(data);
			},
			error:console.log
		})
		
	}
	
	function deleteEvent(){
		allEvents[0].remove();
	}
	
	$("#eventTitleInput").on("keyup",function(){
		currentTitle = $(this).val();
		console.log(currentTitle);
	})
	
	function createEventTitle(){
		$(".title").html(currentTitle);
	 }
		
	
	$(document.loginFrm).submit((e)=>{
		e.preventDefault();
		$.ajax({
			url:'${pageContext.request.contextPath}/member/memberLogin.do',
			method:"POST",
 				data:$(e.target).serialize(), 
				succes(resp){
				console.log();
				alert("로그인 성공!");
			},
			error:console.log				
		});
	});
</script>	