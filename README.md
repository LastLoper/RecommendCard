# 신용카드 추천 - Firebase Database사용
- Firebase의 데이테베이스를 이용해서 데이터를 가져와 보여주며, 이미지를 보다 효율적으로 보여주기 위해 Kingfisher/Lottie 라이브러리를 사용한 앱입니다


## 스크린샷
<img src="https://user-images.githubusercontent.com/104996680/203260852-89c0279b-9629-4d95-987a-d09b87a7dac3.png" alt="신용카드 추천 앱" width="650">
<img src="https://user-images.githubusercontent.com/104996680/203260878-34e10d22-7c38-4265-ae56-59e63ae79c03.png" alt="신용카드 추천 앱">
<img src="https://user-images.githubusercontent.com/104996680/203260889-54c70991-1f19-4e54-8ff1-846d401e58fa.png" alt="신용카드 추천 앱">

## 주요 기능 및 목표
- Firebase Realtime Database 사용법 익히기.
- Firebase Firestore Database 사용법 익히기.
- 각 데이터베이스에 저장된 신용카드 목록과 세부 내역을 받아옵니다.
- TableView로 신용카드 목록을 만듭니다.
- 상세화면에서 GIF 신용카드 이미지 및 상세 내용을 보여줍니다.
- Kingfisher와 Lottie-iOS를 사용해 이미지를 보여줍니다.

## 사용 기술
- Firebase Realtime Database.
- Firebase Firestore Database.
- TableView.
- Kingfisher 라이브러리.
- Lottie-ios 라이브러리.

### 입력
- Firestore 및 RealTime Database에 저장된 데이터.

### 출력
- 결과를 TableView로 신용카드 목록을 보여줌.
- Lottie-iOS로 GIF이미지를 보여줌.
- 신용카드 선택시 다른 화면에서 상세내용을 보여줌.

### 목표
- Database의 신용카드 정보를 받아와 리스트로 보여주고, 상세 페이지로 전환할 수 있습니다.
- 데이터를 읽고, 쓰고, 삭제할 수 있습니다.
- 각 데이터베이스의 차이를 이해하고 사용합니다.
- 각 데이터베이스 모두 동일한 결과를 보여줍니다.

## 아키텍처
- MVVM
