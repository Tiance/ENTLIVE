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

class RoomChatViewController: RxViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = RoomChatViewModel()
    let data: [RoomMessage] = []

    var messages = [Message(type: .share, name: "霍金", content: "太阳消失，你还有8分钟的光明", color: .purple),
                    Message(type: .share, name: "爱因斯坦", content: "霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,", color: .orange),
                    Message(type: .share, name: "霍金", content: "太阳消失，你还有8分钟的光明", color: .purple),
                    Message(type: .share, name: "爱因斯坦", content: "霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,", color: .orange),
                    Message(type: .share, name: "霍金", content: "太阳消失，你还有8分钟的光明", color: .purple),
                    Message(type: .share, name: "爱因斯坦", content: "霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,霍金说的对,", color: .orange),
                    Message(type: .share, name: "霍金", content: "太阳消失，你还有8分钟的光明", color: .purple)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        AppEnvironment.current.imService.messages.flatMap { Observable.from($0) }.subscribe(onNext: { [weak self] m in
            let m = Message(type: .share, name: "霍金", content: "太阳消失，你还有8分钟的光明", color: .purple)
            self?.messages.append(m)
            self?.collectionView.insertItemsAtIndexPaths([IndexPath.init(item: (self?.data.count)! - 1, section: 0)], animationStyle: UITableViewRowAnimation.bottom)

//            self?.viewModel.input(message: (self?.messages)!)
        }).disposed(by: disposeBag)

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

    @IBAction func click(_ sender: Any) {
        AppEnvironment.current.imService.testMessage(type: .chat, cmd: .chatNormal)
    }
}

extension RoomChatViewController: ELWaterFlowLayoutDelegate {
    func el_flowLayout(_ flowLayout: ELWaterFlowLayout, heightForRowAt index: Int) -> CGFloat {
        return RoomChatCell.summaryCellHeight(model: messages[index])
    }
}
