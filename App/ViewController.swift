//
//  ViewController.swift
//  ENT-LIVE
//
//  Created by 斌王 on 09/03/2018.
//  Copyright © 2018 斌王. All rights reserved.
//

import UIKit
import Prelude
import RxSwift
import Api
import SwiftProtobuf

class ViewController: RxViewController {

    var requestCode: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        AppEnvironment.current.router.notification
                .subscribe(onNext: {
                    if case MessageRouter.gift(let name) = $0 {
                        print(name)
                    }
                })
                .disposed(by: disposeBag)
        // Do any additional setup after loading the view, typically from a nib.
        _ = view
                |> UIView.lens.layer.cornerRadius .~ 2


        var p = Person.with {
        $0.id = 1
        $0.email = "Willian.wang@hotmail.com"
        }

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func changeEnv(sender: UISegmentedControl) {
        AppEnvironment.switchEnv(envTypeOrder: sender.selectedSegmentIndex)
    }

    @IBAction func send(sender: UIButton) {
        _ = userDetail(id: 1)
                .subscribe(onNext: { rlt in
                    print(rlt.login)
                })

    }

    @IBAction func toLogin() {
        let intent = Intent(data: ["b": "ISA"])
        push(routerType: AppControllerRouter.login, requestCode: 0, intent: intent)
    }

    private func userDetail(id: Int) -> Observable<User> {
        return AppEnvironment.current.api.request(target: .singleUser(id: id))
    }

    override func onRequestResult(_ intent: Intent?) {
        print(intent?.data["a"] ?? "")
    }
}

