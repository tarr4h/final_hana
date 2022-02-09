<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<br>
    <div class="outer">
        <div class="inner-list">
          <div class="inner">
            <img src="images/html5-semantic-tag-1.jpg" alt="">
          </div>
          <div class="inner">
            <img src="images/html5-semantic-tag-2.jpg" alt="">
          </div>
          <div class="inner">
            <img src="images/html5-semantic-tag-3.png" alt="">
          </div>
        </div>
        <div class="button-list">
          <a href="#" class="button-left"><</a>
          <a href="#" class="button-right">></a>
        </div>
      </div>
<script>
const outer = document.querySelector('.outer');
const innerList = document.querySelector('.inner-list');
const inners = document.querySelectorAll('.inner');
let currentIndex = 0; // 현재 슬라이드 화면 
inners.forEach((inner) => {
  inner.style.width = `${outer.clientWidth}px`; // inner의 width를 모두 outer의 width로
})
innerList.style.width = `${outer.clientWidth * inners.length}px`; // innerList의 width를 inner의 width * inner의 개수로 만들기
/* 버튼에 이벤트 등록 */
const buttonLeft = document.querySelector('.button-left');
const buttonRight = document.querySelector('.button-right');
buttonLeft.addEventListener('click', () => {
  currentIndex--;
  currentIndex = currentIndex < 0 ? 0 : currentIndex; // index값이 0보다 작아질 경우 0
  innerList.style.marginLeft = `-${outer.clientWidth * currentIndex}px`; // index만큼 margin을 주어 옆으로 밀기
  clearInterval(interval); // 기존 동작되던 interval 제거
  interval = getInterval(); // 새로운 interval 등록
});
buttonRight.addEventListener('click', () => {
  currentIndex++;
  currentIndex = currentIndex >= inners.length ? inners.length - 1 : currentIndex; // index값이 inner의 총 개수보다 많아질 경우 마지막 인덱스값으로 변경
  innerList.style.marginLeft = `-${outer.clientWidth * currentIndex}px`; // index만큼 margin을 주어 옆으로 밀기
  clearInterval(interval); // 기존 동작되던 interval 제거
  interval = getInterval(); // 새로운 interval 등록
});
</script>
</body>
<style>
.inner img {
    width: 600px;
    height: 500px;
}
.outer {
  width: 800px;
  height: 500px;
  margin: 0 auto;
  overflow-x: hidden;
  text-align: center;
}
.inner-list {
  display: flex;
  transition: .3s ease-out;
  height: 100%;
}
.inner {
  padding: 0 16px;
}
.button-list {
  text-align: center;
  width: 800px;
  top: 30%;
  position: absolute;
  z-index: 2;
  font-size: 60px;
}
.button-left {
    position: absolute;
    left: 15%;
    text-decoration-line : none;
    opacity: 0;
}
.button-right {
    position: absolute;
    right: 15%;
    text-decoration-line : none;
    opacity: 0;
}
.button-left:hover {
    opacity: 1;
    color: rgb(90, 90, 90);
}
.button-right:hover {
    opacity: 1;
    color: rgb(90, 90, 90);
}
</style>
</html>
