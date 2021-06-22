//
//  UserAClassViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/14.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa

class UserAClassViewController: UIViewController {
    var isUpdate: Bool = true
    var disposeBag = DisposeBag()
    var viewModel = UserAClassViewModel()
    
    private let nationalityLabel = BaseLabel(text: "國籍*", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let menuLabel = BaseLabel(text: "Taiwan", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), alignments: .left)
    private let firstNameLabel = BaseLabel(text: "名字*", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let lastNameLabel = BaseLabel(text: "姓氏*", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let idendifierLabel = BaseLabel(text: "身分證字號*", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let idendifierPicLabel = BaseLabel(text: "身分證正面*", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let uploadLabel = BaseLabel(text: "上傳", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    
    private lazy var toastFailedView = WithdrawalToastView(img: toastFailedImg, titleLabel: toastFTitleLabel, detailLabel: toastFDetailLabel, buttonTitle: "確認", action: #selector(didTapBack), vc: self)
    private let toastFailedImg = BaseImageView(image: "No", color: nil)
    private let toastFTitleLabel = BaseLabel(text: "未完成提交", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastFDetailLabel = BaseLabel(text: "資料填寫不完全，請重試", color: .white, font: .systemFont(ofSize: 13, weight: .regular), alignments: .center)

    private let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.937254902, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let updatePicView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.937254902, alpha: 1)
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let dropDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dropDown")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var nationalitys = NationalitysViewModel()
    private let updateImageview = BaseImageView(image: "Accessory", color: nil)
    
    lazy var menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = nationalitys.country
        menu.backgroundColor = .white
        return menu
    }()
    
    private let firstNameTextField = BaseTextField(text: "", placeholder: "")
    private let lastNameTextField = BaseTextField(text: "", placeholder: "")
    private let identifierTextField = BaseTextField(text: "", placeholder: "")
    
    private lazy var firstNameContainerView: InputContainerView = {
        return InputContainerView(textField: firstNameTextField)
    }()
    private lazy var lastNameContainerView: InputContainerView = {
        return InputContainerView(textField: lastNameTextField)
    }()
    private lazy var identifierContainerView: InputContainerView = {
        return InputContainerView(textField: identifierTextField)
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("送出", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "A Class"
        self.tabBarController?.tabBar.isHidden = true
        toastFailedView.isHidden = true
        setupUI()
        setupDropDownMenu()
        setupUpdateView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
    }
    
    func binding() {
        AFManager.shared.uploadImgName
            .subscribe(onNext: { [weak self] imgName in
                self?.uploadLabel.text = imgName
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        view.addSubViews(nationalityLabel,
                         menuView,
                         menuLabel,
                         dropDownImageView,
                         firstNameLabel,
                         lastNameLabel,
                         firstNameContainerView,
                         lastNameContainerView,
                         idendifierLabel,
                         identifierContainerView,
                         idendifierPicLabel,
                         updatePicView,
                         confirmButton,
                         toastFailedView
        )
        updatePicView.addSubViews(uploadLabel, updateImageview)
        
        nationalityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
            make.height.equalTo(18)
        }
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(nationalityLabel.snp.bottom).offset(8)
            make.left.equalTo(nationalityLabel.snp.left)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(50)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.centerY.equalTo(menuView.snp.centerY)
            make.left.equalTo(menuView.snp.left).offset(20)
            make.width.equalTo(menuView.snp.width).multipliedBy(0.5)
            make.height.equalTo(menuView.snp.height)
        }
        
        dropDownImageView.snp.makeConstraints { make in
            make.centerY.equalTo(menuView.snp.centerY)
            make.right.equalTo(menuView.snp.right).offset(-15)
            make.width.height.equalTo(15)
        }
        
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom).offset(25)
            make.left.equalTo(nationalityLabel.snp.left)
            make.width.height.equalTo(nationalityLabel)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom).offset(25)
            make.left.equalTo(lastNameContainerView.snp.left)
            make.width.height.equalTo(nationalityLabel)
        }
        
        firstNameContainerView.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(5)
            make.left.equalTo(nationalityLabel.snp.left)
            make.width.equalTo(view.snp.width).multipliedBy(0.43)
            make.height.equalTo(menuView.snp.height)
        }
        
        lastNameContainerView.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(5)
            make.right.equalTo(menuView.snp.right)
            make.width.equalTo(view.snp.width).multipliedBy(0.43)
            make.height.equalTo(menuView.snp.height)
        }
        
        idendifierLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameContainerView.snp.bottom).offset(25)
            make.left.equalTo(firstNameLabel.snp.left)
            make.width.equalTo(menuView.snp.width).multipliedBy(0.5)
            make.height.equalTo(firstNameLabel.snp.height)
        }
        
        identifierContainerView.snp.makeConstraints { make in
            make.top.equalTo(idendifierLabel.snp.bottom).offset(5)
            make.left.equalTo(firstNameContainerView.snp.left)
            make.right.equalTo(lastNameContainerView.snp.right)
            make.height.equalTo(firstNameContainerView.snp.height)
        }
        
        idendifierPicLabel.snp.makeConstraints { make in
            make.top.equalTo(identifierContainerView.snp.bottom).offset(25)
            make.left.equalTo(firstNameLabel.snp.left)
            make.width.equalTo(menuView.snp.width).multipliedBy(0.5)
            make.height.equalTo(firstNameLabel.snp.height)
        }
        
        updatePicView.snp.makeConstraints { make in
            make.top.equalTo(idendifierPicLabel.snp.bottom).offset(5)
            make.left.equalTo(menuView.snp.left)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(55)
        }

        updateImageview.snp.makeConstraints { make in
            make.centerY.equalTo(updatePicView.snp.centerY)
            make.right.equalTo(updatePicView.snp.right).offset(-20)
            make.width.height.equalTo(20)
        }
        
        uploadLabel.snp.makeConstraints { make in
            make.centerY.equalTo(updatePicView.snp.centerY)
            make.left.equalTo(updatePicView.snp.left).offset(20)
            make.right.equalTo(updateImageview.snp.left)
            make.height.equalTo(updatePicView.snp.height)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(menuView.snp.height)
        }
        
        toastFailedView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        confirmButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        confirmButton.setTitleColor(.white, for: .highlighted)
    }
    
    private func setupDropDownMenu() {
        menu.anchorView = menuView
        menu.bottomOffset = CGPoint(x: 0, y: menuView.bounds.height+50)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        menuView.addGestureRecognizer(gesture)
        
        // callback
        menu.selectionAction = { index, title in
            self.menuLabel.text = title
        }
    }
    
    private func setupUpdateView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapUpdate))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        updatePicView.addGestureRecognizer(gesture)
    }
    
    // MARK: - Selector
    @objc private func didTapMenu() {
        menu.show()
    }
    //點擊上傳view
    @objc private func didTapUpdate() {
        let controller = UpdateIdentifierViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //點擊送出
    @objc private func didTapConfirm() {
        guard self.uploadLabel.text != "上傳",
              self.firstNameTextField.text != "",
              self.lastNameTextField.text != "",
              self.identifierTextField.text != "" else {
            self.toastFailedView.alpha = 1
            self.toastFailedView.isHidden = false
            
            UIView.animate(withDuration: 2.5) {
                self.toastFailedView.alpha = 0
            } completion: { (_) in }
            return
        }
        guard let token = userDefaults.string(forKey: "UserToken"),
              let upload = self.uploadLabel.text,
              let firstName = self.firstNameTextField.text,
              let lastName = self.lastNameTextField.text,
              let identifier = self.identifierTextField.text,
              let nationality = self.menuLabel.text else {
            return
        }
        let param = "country=\(nationality)&firstName=\(firstName)&lastName=\(lastName)&idcard=\(identifier)&idcardimg1=\(upload)&token=\(token)"
        
        self.viewModel.getTradeLogList(param: param, completion: { result in
            DispatchQueue.main.async {
                let controller = UserAClassDetailViewController()
                controller.model = result
                self.navigationController?.pushViewController(controller, animated: true)
                print(result)
                print("getTradeLogList 1123")
            }
        })
    }
    
    @objc private func didTapBack() {
        self.toastFailedView.isHidden = true
    }
}

extension UserAClassViewController {


}


class CustomTextField: UITextField {
    
    init(text: String?, textColor: UIColor?, placeholder: String?) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.textColor = textColor ?? .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class InputContainerView: UIView {
    
    init(textField: UITextField) {
        super.init(frame: .zero)
        
        let spaceView = UIView()
        spaceView.backgroundColor = .clear
        addSubview(spaceView)
        spaceView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(10)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(10)
            make.left.equalTo(spaceView.snp.left).offset(20)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        
        spaceView.layer.cornerRadius = 10
        spaceView.layer.borderWidth = 1
        spaceView.layer.borderColor = #colorLiteral(red: 0.8342679143, green: 0.7959142327, blue: 0.7952387929, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
