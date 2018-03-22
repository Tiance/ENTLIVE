//
// Created by Yamazhiki on 21/03/2018.
// Copyright (c) 2018 ENT-LIVE. All rights reserved.
//

import Foundation
import RxDataSources
import Prelude

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
        collectionViewLayout().edge = .zero
        collectionViewLayout().lineCount = layoutType.numberOfItemInRow
        collectionViewLayout().delegate = self
        collectionViewLayout().vItemSpace = 10
        collectionViewLayout().hItemSpace = 10
        super.viewDidLoad()
    }

    fileprivate func collectionViewLayout() -> ELWaterFlowLayout {
        return collectionView.collectionViewLayout as! ELWaterFlowLayout
    }
}

extension LiveListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        _ = cell.retrieveView(type: UILabel.self, tag: 10)
                |> UILabel.lens.text .~ data[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            layoutType = LiveViewerStyle.line
        } else {
            layoutType = LiveViewerStyle.two
        }
        collectionViewLayout().lineCount = layoutType.numberOfItemInRow
    }
}

extension LiveListViewController: ELWaterFlowLayoutDelegate {
    func el_flowLayout(_ flowLayout: ELWaterFlowLayout, heightForRowAt index: Int) -> CGFloat {
        return layoutType.height
    }
}
