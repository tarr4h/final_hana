<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <meta charset='utf-8' />
    <link href='${pageContext.request.contextPath}/resources/fullcalendar/main.css' rel='stylesheet' />
    <script src='${pageContext.request.contextPath}/resources/fullcalendar/main.js'></script>
    <script src='${pageContext.request.contextPath}/resources/fullcalendar/ko.js'></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="float:left; width:10vw;">
	  <div id='external-events'>
	    <p>
	      <strong>Draggable Events</strong>
	    </p>
	
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 1</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 2</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 3</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 4</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 5</div>
	    </div>
	
	    <p>
	      <input type='checkbox' id='drop-remove' />
	      <label for='drop-remove'>remove after drop</label>
	    </p>
	  </div>
	  <div style="padding:0 10px;">
	  	<button onclick="saveAll();" style="width:100%; background-color:#3788d8; border:1px solid white; color:white;">저장</button>
	  </div>
	  <div style="padding:0 10px;">
	  	<button onclick="deleteEvent();" style="width:100%; background-color:#3788d8; border:1px solid white; color:white;">삭제</button>
	  </div>
	</div>

  <div id='calendar-container' style="float:left; width:80vw;">
     <div id='calendar'></div>
  </div>
</body>
<script>
let calendar;
let allEvents;
document.addEventListener('DOMContentLoaded', function() {
	  var Calendar = FullCalendar.Calendar;
	  var Draggable = FullCalendar.Draggable;

	  var containerEl = document.getElementById('external-events');
	  var calendarEl = document.getElementById('calendar');
	  var checkbox = document.getElementById('drop-remove');

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
	    editable: true,
	    droppable: true, // this allows things to be dropped onto the calendar
	    drop: function(info) {
	      // is the "remove after drop" checkbox checked?
	      if (checkbox.checked) {
	        // if so, remove the element from the "Draggable Events" list
	        info.draggedEl.parentNode.removeChild(info.draggedEl);
	      }
	    },
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
	for(let i=0; < allEvents.length; i++){
		let obj = new Object();
		
		obj.title = allEvents[i]._def.title; // 타이틀
		obj.allday = allEvents[i]._def.allDay; // 하루종일인지
		obj.start = allEvents[i].instance.start; // 시작날짜 및 시간
		obj.end = allEvents[i].instance.end; // 종료날짜 및 시간
		
	 	events.push(obj); // 이벤트 정보를 json문자열 형태로 변환
	}
	
	const jsonString = JSON.stringify();
	console.log(jsonString);
}

function saveCalendarData(data){
	
	$.ajax({
		url:"${pageContext.request.contextPath}/group/saveCalendarData",
		method:"POST",
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
	
</script>
</html>