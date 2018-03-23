//
// Created by Yamazhiki on 21/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import Prelude
import RxSwift
import RxCocoa
import RxDataSources

fileprivate struct NameSectionData {
    var items: [String]
}

extension NameSectionData: SectionModelType {
    typealias Item = String

    init(original: NameSectionData, items: [String]) {
        self.items = items
        self = original
    }
}

fileprivate enum LiveViewerStyle: GridViewLayoutType {
    case line
    case two
    fileprivate var numberOfItemInRow: UInt {
        switch self {
        case .line: return 1
        case .two: return 2
        }
    }
    fileprivate var height: CGFloat {
        switch self {
        case .line: return 500
        case .two: return 200
        }
    }
}

class LiveListViewController: RxViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate var layoutType: GridViewLayoutType = LiveViewerStyle.two
    fileprivate var data = ["Yamazhiki", "ISA", "Barthoomew", "Tiance", "Junyu"]

    override func viewDidLoad() {
        collectionView.rx.itemSelected.asObservable()
                .subscribe(onNext: { [weak self] indexPath in
                    if indexPath.row == 0 {
                        self?.layoutType = LiveViewerStyle.line
                    } else {
                        self?.layoutType = LiveViewerStyle.two
                    }
                    self?.collectionViewLayout().lineCount = self?.layoutType.numberOfItemInRow ?? 0
                }).disposed(by: disposeBag)

        let section = NameSectionData(items: data)


        let dataSource = RxCollectionViewSectionedReloadDataSource<NameSectionData>(
                configureCell: { (ds, v, indexPath, item) -> UICollectionViewCell in
                    let cell = v.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                    _ = cell.retrieveView(type: UILabel.self, tag: 10)
                            |> UILabel.lens.text .~ item
        return cell
    })

        Observable.just([section])
        .bind(to:collectionView.rx.items(dataSource:dataSource))
        .disposed(by:disposeBag)

        super.viewDidLoad()


        _ = collectionViewLayout()
        |> ELWaterFlowLayout.lens.edge .~ .zero
        |> ELWaterFlowLayout.lens.lineCount .~ layoutType.numberOfItemInRow
        |> ELWaterFlowLayout.lens.delegate .~ self
        |> ELWaterFlowLayout.lens.vItemSpace .~ 10
        |> ELWaterFlowLayout.lens.hItemSpace .~ 10
    }

    fileprivate func collectionViewLayout() -> ELWaterFlowLayout {
        return collectionView.collectionViewLayout as! ELWaterFlowLayout
    }
}

extension LiveListViewController: ELWaterFlowLayoutDelegate {
    func el_flowLayout(_ flowLayout: ELWaterFlowLayout, heightForRowAt index: Int) -> CGFloat {
        return layoutType.height
    }
}
