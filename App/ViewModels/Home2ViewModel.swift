//
//  Home2ViewModel.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/21.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class Home2ViewModel: NSObject {
    func getItems() -> Observable<[ItemData]> {
        return Observable.create { (observable) -> Disposable in
            var items: [ItemData] = []
            for i in 0..<10 {
                let h = Home2Item(name: "麦小兜\(i)", image: "", fans: i*10)
                let d = ItemData(items: [h])
                items.append(d)
            }
            observable.onNext(items)
            return Disposables.create()
        }
    }
}
