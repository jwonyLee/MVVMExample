//
//  Observable.swift
//  MVVMExample
//
//  Created by 이지원 on 2021/04/05.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> Void

    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
