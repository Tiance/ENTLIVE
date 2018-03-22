//
//  HomeContainerViewController.swift
//  ENTLIVE
//
//  Created by 斌王 on 21/03/2018.
//  Copyright © 2018 斌王. All rights reserved.
//

import Foundation

class HomeContainerViewController: RxViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "首页"

        NotificationCenter.default.post(name: Notification.Name.update, object: nil)
    }
}
