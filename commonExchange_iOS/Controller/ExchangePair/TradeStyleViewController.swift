//
//  TradeStyleViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/11.
//

import UIKit
import RxSwift
import RxCocoa

class TradeStyleViewController: UIViewController {
    var tradeStyleIndex = BehaviorRelay<Int>(value: 0)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(TradeStyleViewCell.self, forCellWithReuseIdentifier: TradeStyleViewCell.identifier)
        return cv
    }()
    
    var currentIndex: Int = 0
    var didSelectedIndex: BehaviorRelay = BehaviorRelay<Int>(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    
    private func setupUI() {
        view.addSubViews(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

    

}

extension TradeStyleViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TradeStyleType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TradeStyleViewCell.identifier, for: indexPath) as! TradeStyleViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = .init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        cell.configure(with: TradeStyleType.allCases[indexPath.item])
        if indexPath.item == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
            cell.styleLabel.textColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TradeStyleViewCell
        
        if indexPath.item == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        }
        if indexPath.item == 1 {
            cell.backgroundColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        }
        
        cell.styleLabel.textColor = .white
        self.tradeStyleIndex.accept(indexPath.item)
        self.currentIndex = indexPath.item
        self.didSelectedIndex.accept(currentIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TradeStyleViewCell
        cell.backgroundColor = .clear
        cell.styleLabel.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
}
