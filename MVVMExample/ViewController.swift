//
//  ViewController.swift
//  MVVMExample
//
//  Created by 이지원 on 2021/04/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    private var viewModel: ViewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.text.bind { helloText in
            DispatchQueue.main.async {
                self.label.text = helloText
            }
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        viewModel.userTriggeredButton()
    }

}

