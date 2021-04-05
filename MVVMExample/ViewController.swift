//
//  ViewController.swift
//  MVVMExample
//
//  Created by 이지원 on 2021/04/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    private var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ViewModel()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        viewModel?.userTriggeredButton()
    }

}

