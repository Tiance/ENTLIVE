//
// Created by Yamazhiki on 21/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Prelude

class HomeV2ViewController: RxViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = Home2ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "发现"

        collectionViewLayout()

        let dataSource = RxCollectionViewSectionedReloadDataSource<ItemData>.init(configureCell: { (ds, v, indexPath, item) -> UICollectionViewCell in
            let cell = v.dequeueReusableCell(withReuseIdentifier: "Home2Cell", for: indexPath)
            _ = cell.retrieveView(type: UILabel.self, tag: 11)
                |> UILabel.lens.text .~ item.name
            _ = cell.retrieveView(type: UILabel.self, tag: 33)
                |> UILabel.lens.text .~ "\(item.fans)人"
            return cell
        })

        collectionView.rx.itemSelected.asObservable().subscribe({ [weak self] _ in
            self?.present(routerType: AppControllerRouter.RoomChat, requestCode: 0)
        }).disposed(by: disposeBag)

        viewModel.getItems().bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    fileprivate func collectionViewLayout() {
        let layout = ELWaterFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.edge = .zero
        layout.lineCount = 2
        layout.delegate = self
        layout.vItemSpace = 10
        layout.hItemSpace = 10
    }
}

extension HomeV2ViewController: ELWaterFlowLayoutDelegate {
    func el_flowLayout(_ flowLayout: ELWaterFlowLayout, heightForRowAt index: Int) -> CGFloat {
        return 200
    }
}
