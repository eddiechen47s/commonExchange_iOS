//
//  AdHomeViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol AdHomeDidTapItem: AnyObject {
    func didTapItem(selectedItem: Int)
}

class AdHomeViewCell: UICollectionViewCell {
    
    static let identifier = "AdHomeViewCell"
    let adImge: [String] = ["ice", "ice1", "ice2"]
//    weak var delegate: AdHomeDidTapItem?
    var didSelectedIndex = BehaviorRelay<Int>(value: 0)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ADViewCell.self, forCellWithReuseIdentifier: ADViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.isSelected = false
        pc.currentPage = 0
        pc.numberOfPages = adImge.count
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupUI()
    }
    
    private func setupUI() {
        addsubViews(collectionView,
                    pageControl)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AdHomeViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adImge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ADViewCell.identifier, for: indexPath) as! ADViewCell
        cell.configue(imageName: adImge[indexPath.row])
        return cell
    }
    
    // 對齊 UIPageControl 圓點
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
    
    
}


extension AdHomeViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
//        delegate?.didTapItem(selectedItem: indexPath.item)
        self.didSelectedIndex.accept(indexPath.item)
        print(didSelectedIndex.value)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



//MARK: UICollectionViewCell 專用disposeBag
extension Reactive where Base: UICollectionViewCell {
  public var reuseBag: DisposeBag {
        MainScheduler.ensureExecutingOnScheduler()
        var prepareForReuseBag: Int8 = 0
        if let bag = objc_getAssociatedObject(base, &prepareForReuseBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        objc_setAssociatedObject(base, &prepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        _ = sentMessage(#selector(Base.prepareForReuse))
            .subscribe(onNext: { [weak base] _ in
                let newBag = DisposeBag()
                guard let base = base else {return}
                objc_setAssociatedObject(base, &prepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            })
        return bag
    }
}
