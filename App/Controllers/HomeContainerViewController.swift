//
//  HomeContainerViewController.swift
//  ENTLIVE
//
//  Created by 斌王 on 21/03/2018.
//  Copyright © 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift
import Api

class HomeContainerViewController: RxViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "首页"

        NotificationCenter.default.post(name: Notification.Name.update, object: nil)


        _ = AppEnvironment.userEvents.subscribe(onNext: { _ in
            print("------")
        })

        AppEnvironment.auth(accessToken: CommonAccessToken(token: ""))
        _ = load()
                .subscribe(onNext: { rlt in
                    print(rlt)
                })


    }

    private func load() -> Observable<[User]> {
        return AppEnvironment.current.api.request(target: .users)
    }
}
