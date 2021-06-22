//
//  OderDetailViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit

class OderDetailViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(OderDetaiTypeViewCell.self, forCellWithReuseIdentifier: OderDetaiTypeViewCell.identifier)
        cv.register(OderDetaiViewCell.self, forCellWithReuseIdentifier: OderDetaiViewCell.identifier)
        cv.register(OderDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OderDetailHeaderView.identifier)
        return cv
    }()
    
    var model: AllOrderRecord!
    var coinPair = ""

    private let detailView = BaseView(color: .clear)
    private let amountLabel = BaseLabel(text: "實際數量：", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    private let totalLabel = BaseLabel(text: "實際總額：", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    private let feeLabel = BaseLabel(text: " 手續費：", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    
    private let amountValueLabel = BaseLabel(text: "0 ETH", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    private let totalValueLabel = BaseLabel(text: "0 BTC", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    private let feeValueLabel = BaseLabel(text: "0.113985 MAX", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    private let totalCostLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    
    private lazy var titleStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [amountLabel, totalLabel, feeLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var detailStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [amountValueLabel, totalValueLabel, feeValueLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    var viewModel = OderDetailViewModel()
    var detailModel = [OderDetail]()
    var dealAmount: Double = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1)
        title = "訂單明細"
        setupUI()

        bindingOrderDetail()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popViewController(animated: false)
    }
    
    private func bindingOrderDetail() {
        LoadingView.shared.showLoader()

        if model != nil {
            let coinPrefix = model.market.uppercased().split(separator: "_")[0]
            let coinSuffix = model.market.uppercased().split(separator: "_")[1]
            viewModel.getMyTradeLogList(tradeId: model.id) { [weak self] result in
                self?.detailModel = result
                for r in result {
                    let num = (r.num as NSString).doubleValue
                    self?.dealAmount += num
                }
                DispatchQueue.main.async {
                    self?.setupUIDetail()
                    for data in result {
                        let num = (data.num as NSString).doubleValue
                        let price = (data.price as NSString).doubleValue
                        self?.amountValueLabel.text = data.num+" "+coinPrefix
                        self?.totalValueLabel.text = (num*price).toString(maxF: 9)+" "+coinSuffix
                        let total = (num*price)
                        var fee: Double = 0
                        if data.feeSell != "" {
                            fee = (data.feeSell as NSString).doubleValue
                        } else {
                            fee = (data.feeBuy as NSString).doubleValue
                        }
                        // 買入沒帶值，待修
                        print(total)
                        print(fee)
                        self?.totalCostLabel.text = ""
                    }
                    self?.collectionView.reloadData()
                }
            }
        } else {
        }
        LoadingView.shared.hideLoader()

    }
    
    private func setupUIDetail() {
        if model != nil {
        self.feeValueLabel.text = (model.fee as NSString).doubleValue.toString(maxF: 6)+" "+model.market.uppercased().split(separator: "_")[1]
        }
        
        if detailModel.count == 0 {
            print("DetailModel nil")
            titleStack.snp.remakeConstraints { make in
                make.bottom.equalTo(collectionView.snp.bottom).offset(-60)
                make.left.equalTo(view.snp.centerX).offset(-20)
                make.width.equalTo(detailView.snp.width).multipliedBy(0.4)
                make.height.equalTo(70)
            }
        }
    }
    
    // MARK: - Helpers
    private func setupUI() {
        view.addSubViews(collectionView,
                         detailView)
        
        detailView.addSubViews(titleStack, detailStack, totalCostLabel)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.right.right.equalToSuperview().offset(-20)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(100)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.top)
            make.left.equalTo(view.snp.centerX).offset(-20)
            make.width.equalTo(detailView.snp.width).multipliedBy(0.4)
            make.height.equalTo(70)
        }
        
        detailStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.top).offset(-1)
            make.right.equalTo(detailView.snp.right)
            make.width.equalTo(detailView.snp.width).multipliedBy(0.6)
            make.height.equalTo(70)
        }
        
        totalCostLabel.snp.makeConstraints { make in
            make.top.equalTo(detailStack.snp.bottom).offset(1)
            make.right.equalTo(detailView.snp.right)
            make.width.equalTo(detailView.snp.width).multipliedBy(0.6)
            make.height.equalTo(20)
        }
        
    }
    
}

extension OderDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 && indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OderDetaiTypeViewCell.identifier, for: indexPath) as! OderDetaiTypeViewCell
            cell.backgroundColor = .white
            if model != nil {
                cell.configure(with: model)
                cell.statusLabel.text = self.dealAmount.toString()+"/"+model.num
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OderDetaiViewCell.identifier, for: indexPath) as! OderDetaiViewCell
        let vm = detailModel[indexPath.row]
        cell.configure(with: vm)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.collectionView.frame.width, height: 300)
        }
        return CGSize(width: self.collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OderDetailHeaderView.identifier, for: indexPath) as! OderDetailHeaderView
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            if detailModel.count == 0 {
                return CGSize(width: view.frame.size.width, height: 0)
            }
            return CGSize(width: view.frame.size.width, height: 45)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
}
