//
// Created by Yamazhiki on 22/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import RxSwift

protocol ApplicationViewModelInputs {

}

protocol ApplicationViewModelOutputs {
    var memoryWarning: Observable<Void> { get }
}

protocol ApplicationViewModelType {
    var inputs: ApplicationViewModelInputs { get }
    var outputs: ApplicationViewModelOutputs { get }
}

class ApplicationViewModel: ApplicationViewModelType {
    fileprivate let memoryWarningSubject = PublishSubject<Void>()

    var inputs: ApplicationViewModelInputs {
        return self
    }
    var outputs: ApplicationViewModelOutputs {
        return self
    }

}

extension ApplicationViewModel: ApplicationViewModelOutputs {

    /*inputs*/
    var memoryWarning: Observable<Void> {
        return memoryWarningSubject.asObservable()
    }
}

extension ApplicationViewModel: ApplicationViewModelInputs {

}
