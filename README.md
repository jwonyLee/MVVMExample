# MVVMExample

> 이 예제는 `Observable` 클래스를 이해하면 90%는 이해한 예제다. 그렇지만, 나는 이해하는 게 너무 어려웠다. 클로저가 어렵네😢

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

`value` 값이 바뀌면, 후행 클로저 `helloText`로 `value`가 캡쳐되고(?) 클로저 내부를 실행한다.


## 참고 자료

- [간단한 예제로 살펴보는 iOS Design/Architecture Pattern: MVVM](https://lena-chamna.netlify.app/post/ios_design_pattern_mvvm/#간단한-MVVM-예제)
- [iOS MVVM Tutorial: Refactoring from MVC](https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc)
- [[TIL] iOS. MVVM without Rxswift](https://memohg.tistory.com/107)
- [MVVM Without Reactive Programming](https://riptutorial.com/ios/example/27354/mvvm-without-reactive-programming#example)
