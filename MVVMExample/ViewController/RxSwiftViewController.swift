//
//  RxSwiftViewController.swift
//  MVVMExample
//
//  Created by 이지원 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    let viewModel = RxSwiftViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindInput()
    }

    private func bindInput() {
        viewModel.valuePS
            .map { String($0) }
            .observe(on: MainScheduler.instance)
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        viewModel.userTriggeredButton()
    }
}
