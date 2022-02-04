<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <div style="width:80%;margin:auto;">
	 <div id='calendar-container' style="width:100%;">
	     <div id='calendar'></div>
	  </div>
  </div>
		
<script>
console.log('asldfjn');
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        });
        calendar.render();
        console.log('asldjf');
      });

</script>
