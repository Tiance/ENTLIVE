//
//  RoomChatViewController.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/23.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Prelude

enum MessageType {
    case common
    case share
    case praise
}

struct RoomMessage {
    var items: [Message]
}

extension RoomMessage: SectionModelType {
    typealias Item = Message

    init(original: RoomMessage, items: [Message]) {
        self.items = items
        self = original
    }
}
struct Message {
    let type: MessageType
    let name: String
    let content: String
    var color: UIColor
}

/*******************************************************************************************/

class RoomChatViewController: RxViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = RoomChatViewModel()
    let data: [RoomMessage] = []

    let messages = [Message(type: .share, name: "霍金", content: "太阳消失，你还有8分钟的光明", color: .purple),
                    Message(type: .share, name: "爱因斯坦", content: "霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,", color: .orange)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AppEnvironment.current.imService.testMessage(type: <#T##IMMessage.CMDTYPE#>, cmd: .chat)

        collectionView.register(RoomChatCell.classForCoder(), forCellWithReuseIdentifier: "RoomChatCell")
        collectionViewLayout()

        let dataSource = RxCollectionViewSectionedReloadDataSource<RoomMessage>.init(configureCell: { (ds, v, indexPath, m) -> UICollectionViewCell in
            let cell = v.dequeueReusableCell(withReuseIdentifier: "RoomChatCell", for: indexPath) as! RoomChatCell
            cell.model = m
            return cell
        })

        viewModel.output.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.input(message: messages)

    }

    fileprivate func collectionViewLayout() {
        let layout = ELWaterFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.edge = .zero
        layout.lineCount = 1
        layout.delegate = self
        layout.vItemSpace = 5
        layout.hItemSpace = 5
    }

}

extension RoomChatViewController: ELWaterFlowLayoutDelegate {
    func el_flowLayout(_ flowLayout: ELWaterFlowLayout, heightForRowAt index: Int) -> CGFloat {
        return RoomChatCell.summaryCellHeight(model: messages[index])
    }
}

/*****************************************************************************************/

internal protocol RoomChatViewModelInputs {
    func input(message: [Message])
}

internal protocol RoomChatViewModelOutputs {
    var output: Observable<[RoomMessage]> { get }
}

internal protocol RoomChatViewModelType {
    var inputs: RoomChatViewModelInputs { get }
    var outputs: RoomChatViewModelOutputs { get }
}

internal struct RoomChatViewModel: RoomChatViewModelType, RoomChatViewModelInputs, RoomChatViewModelOutputs {
    var output: Observable<[RoomMessage]>

    var inputs: RoomChatViewModelInputs {
        return self
    }

    var outputs: RoomChatViewModelOutputs {
        return self
    }

    private let resultSubject = PublishSubject<[RoomMessage]>()

    init() {
        output = resultSubject.asObservable()
    }

    func input(message: [Message]) {
        var msgs: [Message] = []
        for m in message {
            msgs.append(m)
        }
        let roomMessage = RoomMessage(items: msgs)
        resultSubject.onNext([roomMessage])
    }

}
