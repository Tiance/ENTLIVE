//
//  RoomUsersViewController.swift
//  ENTLIVE
//
//  Created by 姜楠 on 2018/3/27.
//  Copyright © 2018年 斌王. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Prelude

class RoomUsersViewController: RxViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = RoomUsersViewModel()
    let users = [RoomUser(name: "霍金", image: UIImage.init(named: "3")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "4")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "5")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "6")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "5")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "4")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "3")!, id: 1),
                 RoomUser(name: "霍金", image: UIImage.init(named: "1")!, id: 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout()

        let dataSource = RxCollectionViewSectionedReloadDataSource<RoomUserSection>.init(configureCell: { (ds, v, indexPath, m) -> UICollectionViewCell in
            let cell = v.dequeueReusableCell(withReuseIdentifier: "RoomUserCell", for: indexPath)
            _ = cell.retrieveView(type: UIImageView.self, tag: 11)
                |> UIImageView.lens.image .~ m.image
                |> UIImageView.lens.layer.cornerRadius .~ 32
                |> UIImageView.lens.layer.masksToBounds .~ true
            return cell
        })

        viewModel.output.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.input(users: users)
    }

    fileprivate func collectionViewLayout() {
        let layout = ELWaterFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.edge = .zero
        layout.lineCount = 1
        layout.delegate = self
        layout.vItemSpace = 3
        layout.hItemSpace = 3
        layout.scrollDirection = .horizontal
    }

}
extension RoomUsersViewController: ELWaterFlowLayoutDelegate {
    func el_flowLayout(_ flowLayout: ELWaterFlowLayout, heightForRowAt index: Int) -> CGFloat {
        return 64
    }
}
