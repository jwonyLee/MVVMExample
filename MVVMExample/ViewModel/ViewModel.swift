//
//  ViewModel.swift
//  MVVMExample
//
//  Created by 이지원 on 2021/04/05.
//

import Foundation

class ViewModel {

    var text = Observable("")

    func userTriggeredButton() {
        text.value = "Hello"
    }
}
