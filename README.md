# ios-keynote
3-4주차 프로젝트

## 아이패드 앱 프로젝트 (2023/07/18 19:12)

- `Slide` 프로토콜 정의
- 정사각형 슬라이드 `SquareSlide` 클래스 구현
- Slide 인스턴스를 생성해주는 `SlideFactory` 구현

## Slide 속성 변경 기능 (2023/07/24 21:13)

![Simulator Screen Recording - iPad Pro (11-inch) (4th generation) - 2023-07-24 at 20 47 40](https://github.com/softeerbootcamp-2nd/ios-keynote/assets/68235938/75503f04-67a6-4f2d-acb7-aaa1d15ec54b)

- 슬라이드 터치 시 선택, 빈 영역 터치 시 선택 취소
- 슬라이드 선택 시 오른쪽 속성(배경색, 투명도) 설정 활성화 & 속성 변경 시 모델과 화면 업데이트  

- 새로운 슬라이드를 생성하고 관리해주는 `SlideManager` 구현
- SlideManager 테스트코드 작성

### 구조

![image](https://github.com/softeerbootcamp-2nd/ios-keynote/assets/68235938/c7b9bab3-c30e-4e5f-9521-fca57bc0ba48)
