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

class ViewController: UIViewController, RequestResultType {

    var requestCode: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing: self))
        // Do any additional setup after loading the view, typically from a nib.
        _ = view
                |> UIView.lens.layer.cornerRadius .~ 2

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
        let intent = Intent()
        intent.setObject(key: "b", value: "ISA")
        push(routerType: AppRouter.login, requestCode: 0, intent: intent)
    }

    private func userDetail(id: Int) -> Observable<User> {
        return AppEnvironment.current.api.request(target: .singleUser(id: id))
    }

    func onRequestResult(_ requestCode: Int, resultCode: Int, intent: Intent?) {
        let a: String? = intent?.getObject(key: "a")
        print(a ?? "")
    }
}

