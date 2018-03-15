//
// Created by yamazhiki on 13/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation
import RxSwift

internal protocol LoginViewModelInputs {
    func submit()
}

internal protocol LoginViewModelOutputs {
    var loginResult: Observable<Int> { get }
}

internal protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

internal struct LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }

    private let loginResultSubject = PublishSubject<Int>()

    let loginResult: Observable<Int>

    init() {
        loginResult = loginResultSubject.asObservable()
    }

    func submit() {
        loginResultSubject.onNext(1)
    }


}


