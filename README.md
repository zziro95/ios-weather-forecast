# 🌦️ 날씨정보 프로젝트 🌦️
- 프로젝트 기간: 2021.01.18 ~ 2021.01.24   
- 개인 프로젝트 :man_technologist:   
---
## 구현된 기능
- 현재 날씨 API와 5일 예보 API를 통해 전달받은 데이터를 활용할 수 있도록 모델 타입 구현
- 각 타입 JSON 샘플 데이터를 이용한 테스트
- [모델 타입 구조](https://github.com/zziro95/ios-weather-forecast/blob/1-zziro/images/ModelUML.png)
   
---
## 학습 키워드
- iOS Deployment Target
- available
- JSON
- HTTP
- Codable
- Decodable
- CodingKey
- Core Location
- XCTest
   
---
## 트러블 슈팅
### 1. Deployment Target
- 문제 상황   
    - fork 해온 저장소를 clone 하여 프로젝트를 진행하려 했을 때 `AppDelegate`와 `SceneDelegate`에 아래와 같은 오류가 쏟아져 나왔습니다.   
    - `UIScene' is only available in iOS 13.0 or newer`
    - `UISceneConfiguration' is only available in iOS 13.0 or newer`
    - `UISceneSession' is only available in iOS 13.0 or newer`
    - `ConnectionOptions' is only available in iOS 13.0 or newer`
    
- 고민 과정   
    - 공통적인 키워드는 `UIScene`와 `iOS 13.0`임을 확인할 수 있었고,  오류 메세지의 내용은 키워드들이 `iOS 13.0`이상에서만 사용할 수 있다는 것이었습니다.   
    - `UIScene`, `AppDelegate`와 `SceneDelegate`에 대해 알아보았고, `AppDelegate`와 `SceneDelegate`로 분리된 게 13.0 버전 기준임을 알게 되었습니다.   
   
    - 현재 프로젝트 버전은 12.0 이고 `UIScene`과 관련된 클래스와 메서드들은 13.0 버전 이상에서만 사용할 수 있기 때문에 해결방안으로는 아래 두 가지 방법이 있음을 확인하였습니다.   
   
```swift
1. 프로젝트의 Deployment Target을 13.0 이상으로 변경해 준다.
2. Deployment Target을 변경하지 않고 13.0 이상에서 UIScene과 관련된 메서드들을 사용할 수 있도록 `@available(iOS 13.0, *)` 어노테이션을 붙여준다.
```
   
- 해결 방안   
    - 2번 방법을 선택하였고 iOS 13.0이상 버전에서도 사용할 수 있도록 `AppDelegate`와 `SceneDelegate`에 `@available(iOS 13.0, *)` 코드를 추가해 해결하였습니다.   
    - [문제 해결 커밋](https://github.com/zziro95/ios-weather-forecast/commit/98c9aac2c2a74ae7c3c82913abd878418ac720ff)   
   
    - 1번 방법으로 해결하기 위해서는 `TARGETS iOS Deployment Target`을 바꿔줘야 한다는 것도 알게 되어 추가로 [정리](https://github.com/zziro95/zzipository/blob/main/iOS/iOS%20Deployment%20Target.md)해 보았습니다.   
   
### 2. CodingKey
- 문제 상황
    - 처음 CodingKey를 적용시켰을 경우 API 문서에서 받아오는 JSON 데이터의 키값이 `snake_case`로 되어있기 때문에 `camel Case`로 변경해 주는 용도로 만 사용하였습니다.
    - 그러다 보니 프로퍼티의 네이밍이 [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)에서 지양하는 약어를 사용하게 되고 명확하지 않은 네이밍이 되었습니다.
- 해결 방안
    - 받아오는 JSON 데이터의 키값이 어떤 의미인지 파악하고 CodingKey를 활용하여 보다 명확한 네이밍을 가지도록 수정하였습니다.
    - [문제 해결 커밋](https://github.com/lina0322/ios-weather-forecast/commit/3f25e66e77f17fcadef7fab6d03ad8a0d2e65bbf)중 하나 입니다.
 
 ---
## 고민한 점
### 타입
- 문제 상황
    - `CurrentWeather(현재 날씨)`, `FiveDaysWeather(5일 예보)` 타입 생성 과정에서 공통으로 필요한 타입, Main, Rain, Snow 등의 타입이 CurrentWeather과 FiveDayWeather 타입에 공통적으로 등장하지만 API를 통해 받게 되는 JSON 데이터에서는 **전달 받는 데이터의 차이**가 있었습니다.   
    - Rain으로 예를 들자면 `CurrentWeather(현재 날씨)`는 1h, 3h를 전달받고  `FiveDaysWeather(5일 예보)`는 3h만 전달받습니다.   
    - 이 상황에서 공통으로 필요한 타입을 `1. 각 타입의 내부에 선언하여 가지고 있는 경우`, `2. 공통된 타입을 만들되 API를 통해 데이터를 받을 수도 있고 그렇지 않을지도 모르는 프로퍼티를 옵셔널 타입으로 선언하여 같이 사용하는 경우`에 대해 고민하게 되었습니다.   
- 고민 과정
    - API를 통해 받게 되는 데이터의 구조가 바뀌게 될 경우를 고려하여 `1. 각 타입의 내부에 선언하여 가지고 있는 경우`를 선택하여 진행하였고 그에 따른 장단점에 대해 생각해 보았습니다.
    - 장점
        - 서버에서 뿌려주는 (`CurrentWeather(현재 날씨)`, `FiveDaysWeather(5일 예보)`) JSON 데이터의 구조가 바뀔 경우 각각 독립된 타입에서 바뀐 부분만 수정해 주면 된다. 
    - 단점
        - 공통되는 타입이 많을수록 중복 코드가 많아진다. (실제로 적용하는 과정에서 생각보다 엄청난 양의 중복 코드를 확인하였습니다)
        - `CurrentWeather(현재 날씨)`,  `FiveDaysWeather(5일 예보)` 타입의 뎁스가 깊어지고, 가독성이 떨어진다.
- 결론
    - 선택한 방법으로 프로젝트를 진행해본 결과 위와 같은 장점이 있지만 관련된 또 다른 api의 데이터를 받아와야 한다면 또 다른 타입을 선언해 주어야 하고 그 과정에서 단점이 더 커질 것으로 예상되었습니다. 
    - `2. 공통된 타입을 만들되 API를 통해 데이터를 받을 수도 있고 그렇지 않을지도 모르는 프로퍼티를 옵셔널 타입으로 선언하여 같이 사용하는 경우`로 리팩토링을 진행하는 방향이 유지 보수에 좀 더 용이할 것이라 판단하였습니다.   

### 프로퍼티
- 문제 상황
    - 어떤 데이터를 필수로 받아와야 하는지 기획서와 API 문서에 나와있지 않아 스스로 판단해야 하는 상황을 마주하였습니다.
- 고민 과정
    - UI에 어떤 데이터를 보여줄 것인지, 그 데이터를 보여주려면 어떤 프로퍼티가 필요하다는 건 유추할 수 있었지만, 모델을 설계하는 과정에서 보이는 부분만 생각해선 안될 것 같았습니다.
    - 유지 보수가 용이한 상태를 만든다는 것은 기획서가 변경되었을 때에도 유연하게 대처할 수 있는 구조를 설계하는 것이라고 생각했습니다.
    - 그렇기 때문에 받아올 수 있는 데이터를 언제든 사용할 수 있도록 모두 받아오는 경우가 기획서의 변경에도 대처할 수 있는 방안이라고 생각하여 적용하였습니다.
- 결론
    - 프로젝트에서 진행한 것처럼 API를 통해서 모든 데이터를 받아올 수 있게 만드는 경우는 **받아는 왔지만 사용하지 않았던 데이터가 필요하게 되는 경우**에는 유리하지만 반대로 생각하면 사용하지 않을 데이터를 무의미하게 가지고 있는 것이라는 생각이 들었습니다.
    - 또한 모바일 앱의 경우 모델이 너무 무거워진다면 차지하는 메모리가 커지기 때문에 사용자가 앱을 사용하는 도중에 불편함을 겪게 될 가능성이 커지게 된다고 생각이 들었습니다. 
    - 프로젝트에서 진행한 방향보다는 기획서에 필요한 프로퍼티만 선언해 데이터를 받게 하고 추가적으로 기획서가 변경될 경우 필요한 데이터를 받을 수 있게 수정하는 쪽이 더 효율적이라고 생각하게 되었습니다.   

### Decodable과 CodingKey
- 문제 상황
    - 처음에는 `Codable`을 채택하였지만 이 프로젝트에서는 Encoding을 할 경우가 없을 것으로 예상되기 때문에 `Decodable`을 채택하는 방향으로 수정하였습니다.   
    - [Decodable](https://developer.apple.com/documentation/swift/decodable)과 [CodingKey](https://developer.apple.com/documentation/swift/codingkey)를 공부하다 보니 애플 공식 문서에 init을 필수로 구현해야 한다는 것을 알게 되었습니다.   
    - 그러나 프로젝트에서 JSON 데이터를 다룰 때 init을 구현하지 않아도 별다른 오류가 발생하지 않아 의문이 생겼었습니다.   
   
- 고민 과정
    - 궁금증을 풀기 위해서 이니셜라이저에 대해 살펴봐야 할 거라고 생각이 들었고, 살펴봤을 때 구조체의 멤버 와이즈 이니셜라이저가 실마리를 푸는 시작점이 되어 줄줄 알았지만 멤버 와이즈 이니셜라이저를 정리해보니 이슈와는 거리가 멀어 보였습니다.   
    - 어떤 키워드로 접근, 공부해야 할 지에대한 판단이 오랜 시간이 지남에도 서지 않아 프로젝트 리뷰어 `민디`에게 도움을 요청하였습니다.   
   
- 결론
    - 질문의 답으로 [Swift-Evolution](https://github.com/apple/swift-evolution/blob/main/proposals/0166-swift-archival-serialization.md) 문서를 참고해보길 권하셨고, 살펴본 결과 `Codable`, `Encodable`, `Decodable`, `CodingKey` 프로토콜을 채택한 타입의 경우 사용자의 정의가 필요하지 않은 경우라면 `init` 혹은 `Instance Property`들이 컴파일러에 의해 자동으로 생성된다는 것을 확인하였습니다.   
    - 따라서 필수 구현인 init을 구현하지 않아도 오류가 나지 않음을 알아낼 수 있었습니다.    
