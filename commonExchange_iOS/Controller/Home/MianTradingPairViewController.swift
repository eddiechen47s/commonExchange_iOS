//
//  MianTradingPairViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/2/27.
//

import UIKit
import RxSwift
import RxCocoa

class MainTradingPairViewController: UIViewController {
    
    private let viewModel = MainTradingPairViewModel()
    var disposeBag = DisposeBag()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(MainTradingPairViewCell.self, forCellWithReuseIdentifier: MainTradingPairViewCell.identifier)
        return cv
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        binding()
        collectionView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        WsManager.shared.mainPairChange
//            .subscribe(onNext: { [weak self] data in
//                self!.viewModel.model.removeAll()
//                let tether = data.tether
//                let bitcoin = data.bitcoin
//                let ethereum = data.ethereum
////                
//                self?.viewModel.model.append(bitcoin)
//                self?.viewModel.model.append(ethereum)
//                self?.viewModel.model.append(tether)
//
//
//                DispatchQueue.main.async {
//                    self?.collectionView.reloadData()
//                }
//            })
//            .disposed(by: disposeBag)
    }
    
    deinit {
        print("MainTradingPairViewController deinit")
    }
    
    // MARK: - Helpers
    private func binding() {
        LoadingView.shared.showLoader()
        homeQueue.async {
            self.viewModel.load {
                    self.collectionView.reloadData()
                    self.collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
                    LoadingView.shared.hideLoader()
                }
            }
        }
    }
    
    func setupUI() {
        view.addSubViews(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.edges.equalToSuperview()
            make.height.equalTo(view.snp.height)
        }
    }

}

extension MainTradingPairViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = viewModel.model[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTradingPairViewCell.identifier, for: indexPath) as! MainTradingPairViewCell
        cell.configure(with: vm)
        return cell
    }
}

extension MainTradingPairViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = viewModel.model[indexPath.item]
        let symbol = vm.base.uppercased()+" / "+vm.target.uppercased()
        userDidSelectedPair = symbol
        let controller = createNavController(vc: ExchangePairViewController(), title: symbol, image: nil, selectedImage: nil, tag: 1)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
