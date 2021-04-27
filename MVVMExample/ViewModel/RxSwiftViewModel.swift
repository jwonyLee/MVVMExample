//
//  RxSwiftViewModel.swift
//  MVVMExample
//
//  Created by 이지원 on 2021/04/27.
//

import Foundation
import RxSwift

class RxSwiftViewModel {

    var value = 0 {
        didSet {
            valuePS.onNext(value)
        }
    }
    var valuePS = PublishSubject<Int>()

    func userTriggeredButton() {
        value += 1
    }
}
