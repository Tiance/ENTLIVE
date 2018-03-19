//
// Created by yamazhiki on 13/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Prelude

class LoginViewController: RxViewController {
    let viewModel: LoginViewModelType = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        print(intent!.data["b"] ?? "")
        viewModel.outputs.loginResult.subscribe(onNext: { rlt in
            print(rlt)
        }).disposed(by: disposeBag)

        let btn = UIButton(type: .infoDark)
                |> UIButton.lens.frame .~ CGRect.init(x:100, y: 100, width:100, height:100)
        |> UIButton.lens.targets .~ [(self, #selector(loginHandle), .touchUpInside)]

        view.addSubview(btn)


    }


    override func bindViewModel() {

    }

    @IBAction func loginHandle() {
        let intent = Intent(data: ["a": "hello world"])
        pop(resultCode: 0, intent: intent)

        viewModel.inputs.submit()
    }


}
