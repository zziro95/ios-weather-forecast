# 날씨정보 프로젝트
## 구현된 기능
- 현재 날씨 API와 5일 예보 API를 통해 전달받은 데이터를 활용할 수 있도록 모델 타입 구현
- 각 타입 JSON 샘플데이터를 이용한 테스트
- [모델 타입 구조](https://github.com/zziro95/ios-weather-forecast/blob/1-zziro/images/ModelUML.png)
<br>

---
## 학습 키워드
- iOS Deployment Target
- available
- JSON
- HTTP
- Codable
- Decodable
- CodingKey
...

<br>

---
## 트러블 슈팅
1. Deployment Target
**문제 상황**<br>
fork 해온 저장소를 clone하여 프로젝트를 진행하려했을 때 `AppDelegate`와 `SceneDelegate`에 아래와 같은 오류가 쏟아져 나왔다.<br>
 - `UIScene' is only available in iOS 13.0 or newer`
 - `UISceneConfiguration' is only available in iOS 13.0 or newer`
 - `UISceneSession' is only available in iOS 13.0 or newer`
 - `ConnectionOptions' is only available in iOS 13.0 or newer`
 
**고민 과정**<br>
공통적인 키워드는 `UIScene`와 `iOS 13.0`임을 확인 할 수 있었고,  오류 메세지의 내용은 키워드들이 `iOS 13.0`이상에서만 사용할 수 있다는 것이였다. <br>
`UIScene`, `AppDelegate`와 `SceneDelegate`에 대해 알아보았고, `AppDelegate`와 `SceneDelegate`로 분리된게 13.0 버전 기준임을 알게 되었다. <br>
<br>
현재 프로젝트 버전은 12.0 이고 `UIScene`과 관련된 클래스와 메서드들은 13.0 버전 이상에서만 사용할 수 있기 때문에 해결방안으로는  <br>
1. 프로젝트의 Deployment Target을 13.0 이상으로 변경해주거나 <br>
2. `@available(iOS 13.0, *)` 어노테이션을 붙여주는 방법이 있다는것을 알게 되었다. <br>
<br>

**해결 방안**<br>
2번 방법을 선택 하였고 iOS 13.0이상 버전에서도 사용할 수 있도록 `AppDelegate`와 `SceneDelegate`에 `@available(iOS 13.0, *)` 코드를 추가해 해결하였다. <br>
[문제 해결 커밋](https://github.com/zziro95/ios-weather-forecast/commit/98c9aac2c2a74ae7c3c82913abd878418ac720ff) <br>
<br>

1번 방법으로 해결하기 위해서는 `TARGETS iOS Deployment Target`을 바꿔줘야 한다는것도 알게되어 추가로 [정리](https://github.com/zziro95/zzipository/blob/main/iOS/iOS%20Deployment%20Target.md)해 보았다. <br>

2. 
 
 <br>

 ---
## 고민한 점
- 모델 설계
 구조 - `CurrentWeather(현재 날씨`) `FiveDaysWeather(5일 예보)` 타입 생성 과정에서 공통으로 필요한 타입,<br>
 Main, Rain, Snow의 타입이 CurrentWeather과 FiveDayWeather 타입에 공통적으로 등장하지만 API를 통해 받게되는 JSON데이터에서는 전달 받는 데이터의 차이가 있었습니다.(Rain으로 예를 들자면 현재날씨는 1h,3h를 전달받고 5일일기예보는 3h만 전달받습니다.)<br>
필수데이터와 모델설계. 다 가져와야하는지 필요한 것만 가져오면되는지<br>
그에따른 타입에 옵셔널 설정<br>
<br>

- Decodable과 CodingKey
처음에는 `Codable`을 채택하였지만 이 프로젝트에서는 Encoding을 할 경우가 없을 것으로 예상되기 때문에 `Decodable`을 채택하는 방향으로 수정하였습니다. <br>
[Decodable](https://developer.apple.com/documentation/swift/decodable)과 [CodingKey](https://developer.apple.com/documentation/swift/codingkey)를 공부하다 보니 애플 공식문서에 init을 필수로 구현해야 한다는 것을 알게되었습니다. <br>
그러나 프로젝트에서 JSON 데이터를 다룰때 init을 구현하지 않아도 별다른 오류가 발생하지 않아 의문이 생겼었습니다. <br>
<br>

궁금증을 풀기 위해서 이니셜라이저에 대해 살펴봐야 할거라고 생각이 들었고, 살펴봤을때 구조체의 멤버 와이즈 이니셜라이저가 실마리를 푸는 시작점이 되어줄줄 알았지만 멤버 와이즈 이니셜라이저를 정리해보니 이슈와는 거리가 멀어보였습니다. <br>
어떤 키워드로 접근, 공부해야 할 지에대한 판단이 오랜 시간이 지남에도 서지 않아 프로젝트 리뷰어 `민디`에게 도움을 요청하였습니다. <br>
<br>

질문의 답으로 [Swift-Evolution](https://github.com/apple/swift-evolution/blob/main/proposals/0166-swift-archival-serialization.md) 문서를 참고해보길 권하셨고, 살펴본 결과 `Codable`, `Encodable`, `Decodable`, `CodingKey` 프로토콜을 채택한 타입의 경우 사용자의 정의가 필요하지 않은 경우라면 `init` 혹은 `Instance Property`들이 컴파일러에 의해 자동으로 생성된다는 것을 확인하였습니다. <br>
따라서 필수 구현인 init을 구현하지 않아도 오류가 나지 않음을 알아낼 수 있었습니다. <br>
<br>


 정리해야 할 것 <br>
 
 2. struct class <br>
 3. init <br>
 4. json <br>
 5. http <br>



<br>

---
## 회고를 하며 추후 진행하거나 수정하고 싶은 내용

 <br>

 ---
## 예상되는 질문 (README 완성 후 삭제)
UIScene이 생겨나게 된이유 > 멀티윈도우
appdelegate, scene delegate역할 > WWDC
