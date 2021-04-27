# MVVMExample

## 동작 화면
버튼을 터치하면 label의 숫자가 올라가는 단순한 예제

<img src="https://user-images.githubusercontent.com/15073405/116206016-51315100-a779-11eb-90a9-b87c7efb0e36.png" alt="Property Observer 동작 화면" width="300"/><img src="https://user-images.githubusercontent.com/15073405/116206338-a5d4cc00-a779-11eb-888a-a9851704f34a.png" alt="RxSwift 동작 화면" width="300"/>


## Property Observer로 구현한 MVVM

> 이 예제는 `Observable` 클래스를 이해하면 90%는 이해한 예제다. 그렇지만, 나는 이해하는 게 너무 어려웠다. 클로저를 저장한다는 개념이 어려웠다. 😢

`ViewController`의 `label`과 `ViewModel`이 갖고 있는 `text`는 어떻게 연결되어 있을까?

`ViewModel.text`는 `Observable` 타입이다. `Observable`을 살펴보자.

```swift
class Observable<T> {
    // 클로저를 Listner라는 이름으로 타입을 만듦
    typealias Listener = (T) -> Void

    var listener: Listener?
    // Generic 타입의 value 프로퍼티는 값이 바뀌면, 바뀌기 전에 클로저(listner)에 값을 담아서 호출한다.
    var value: T {
        didSet {
            listener?(value)
        }
    }

    // 첫 생성 시에는 didSet이 호출되지 않음
    init(_ value: T) {
        self.value = value
    }

    // 매개 변수로 클로저를 입력받고, 저장한 뒤, value를 호출한다.
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
```

```swift
viewModel.text.bind { helloText in
    DispatchQueue.main.async {
        self.label.text = helloText
    }
}
```

`value` 값이 바뀌면, 저장된 클로저에 `value`를 넣어 실행한다.

## RxSwift로 똑같이 동작하게 작성해보자.

- 이제 RxSwift를 공부하는 입장에서 작성한 것이므로, 이것이 옳은 방법이란 보장은 하지 않음.
- 예제 코드는 곰튀김님의 [ViewModel을 만들어서 사용해 봅시다.](https://www.youtube.com/watch?v=sZjwyvY-xUM)를 참고하여 작성했음!

```swift
viewModel.valuePS
    .map { String($0) }
    .observe(on: MainScheduler.instance)
    .bind(to: label.rx.text)
    .disposed(by: disposeBag)

```

`valuePS` 값을 문자열로 변경(map), 메인 스레드에서 `label.rx.text`로 바인드 한다. `valuePS`는 `value` 값이 변경될 때마다 `didSet`으로 `onNext(value)` 스트림을 넘겨받는다. (?)

```swift
var value = 0 {
    didSet {
        valuePS.onNext(value)
    }
}
var valuePS = PublishSubject<Int>()

func userTriggeredButton() {
    value += 1
}
```

## 참고 자료

- [간단한 예제로 살펴보는 iOS Design/Architecture Pattern: MVVM](https://lena-chamna.netlify.app/post/ios_design_pattern_mvvm/#간단한-MVVM-예제)
- [iOS MVVM Tutorial: Refactoring from MVC](https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc)
- [[TIL] iOS. MVVM without Rxswift](https://memohg.tistory.com/107)
- [MVVM Without Reactive Programming](https://riptutorial.com/ios/example/27354/mvvm-without-reactive-programming#example)
