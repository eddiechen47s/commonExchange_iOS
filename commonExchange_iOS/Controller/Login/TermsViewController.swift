//
//  TermsViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/6.
//

import UIKit

class TermsViewController: UIViewController {
    
    private let termsTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.text = ""
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var backButton = CustomButton(title: "返回", titleColor: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), backgroundColor: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1), action: #selector(didTapBack), vc: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1329908371, green: 0.2336599231, blue: 0.3251249194, alpha: 1)
        setupUI()

        termsTextView.attributedText = termsText.htmlToAttributedString
        termsTextView.textColor = .white
        termsTextView.showsVerticalScrollIndicator = false
        backButton.layer.cornerRadius = 5
        
        backButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        backButton.setTitleColor(.white, for: .highlighted)
    }

    private func setupUI() {
        view.addSubViews(termsTextView,
                         backButton
                        )

        termsTextView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(backButton.snp.top).offset(-20)
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-25)
            $0.left.right.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
    
    @objc private func didTapBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    let termsText = """
                <div class="danger_modal" v-if="dangerFrameCn == true">
                        <div>
                                <div>
                                        <h1 style="text-align:center;">KTrade 使用條款</h1>
                                        <div>
                                                <p>
                                                        本使用條款所稱之「KTrade」，係指KTrade網站(www.ktrade.io)之所有者即京侖科技訊息股份有限公司 (STATECRAFT TECHMOLOGY CO., Limited) (以下簡稱「KTrade」或「本網站」)，為其用戶提供特定數位貨幣(加密貨幣)如比特幣或以太幣等(下稱「數位資產」)買賣掛單的搓合交易平台，以及提供數位資產交易流通社區之相關服務(以下簡稱「KTrade服務」)。以下條款和條件(以下簡稱「本使用條款」)構成使用KTrade服務與本網站的所有用戶(以下簡稱「用戶」、「您」或「您的」)和KTrade之間的契約，並適用於您進入和使用KTrade服務和本網站的情形。
                                                </p>
                                                <p>
                                                        本使用條款和KTrade的隱私權政策，適用於您以任何方式，包括但不限於透過任何其他第三方提供的任何設備或服務的方式，進入和使用KTrade服務及本網站的情形。因此，請仔細閱讀本使用條款。
                                                </p>
                                        </div>
                                        <div>
                                                <h3>
                                                        重要提示：
                                                </h3>
                                                <p>
                                                        本網站在此特別提醒您：
                                                </p>
                                                <div class="indentTwo">
                                                        <p>1.數位資產本身不由任何金融機構或政府背書。數位資產市場是全新的、並沒有明確、穩定的預期；</p>
                                                        <p>2.數位資產交易存在極高風險，其全天不間斷交易，沒有漲跌限制，價格容易大幅波動；</p>
                                                        <p>3.因各國法律、法規和規範性檔的制定或者修改，數位資產交易隨時可能被暫停或被禁止；</p>
                                                        <p>4.數位資產交易有極高風險，並不適合絕大部分人士。您瞭解和理解此投資有可能導致部分損失或全部損失，所以您應該以能承受的損失程度來決定投資的金額。請確認您瞭解和理解數位資產會產生衍生風險。此外，除了上述提及過的風險以外，還會有未能預測的風險存在。</p>
                                                </div>
                                        </div>
                                        <div>
                                                <h3>一、總則</h3>
                                                <p>1. 當您勾選遵守使用條款的選項後，即代表您確認並同意接受本使用條款：
                                                        <div class="indentTwo">
                                                                <p>1.1 您已花費合理時間充分閱讀審閱且完全瞭解本使用條款所有內容。</p>
                                                                <p>1.2 您同意受本使用條款的所有內容約束，始進入或使用 KTrade 服務和本網站。</p>
                                                                <p>1.3 若您不同意使用本使用條款之任一條款及條件，請您切勿啟用和使用KTrade服務或其他方式進入或使用本網站。</p>
                                                                <p>1.4 您一旦登陸本網站、使用本網站的任何服務或任何其他類似行為即表示您已瞭解並完全同意本協定各項內容，包括本網站對本協議隨時所做的任何修改。</p>
                                                        </div>
                                                </p>
                                                <p>2. 當您透過透過以任何方式進入或使用 KTrade 服務和本網站（包括但不限於透過由任何其他第三方提供的設備或服務），均視為您已接受並同意受本使用條款的條款和條件的約束。</p>
                                                <p>3. 當您成為本網站的用戶後，您將獲得一個帳戶號碼及相應的密碼，可於您的帳戶總覽瀏覽您個人資料，該帳戶號碼和密碼由您負責保管；您應當對您的帳戶號碼進行之所有活動和事件負起相關法律責任，前提是您必須根據您適用的法律達到法定成年年齡且具備完全行為能力，並且：
                                                        <div class="indentTwo">
                                                                <p>3.1 您保證交易中涉及到的屬於您的數位資產均為合法取得並所有。</p>
                                                                <p>3.2 您同意您為您自身的交易或非交易行為承擔全部責任和任何收益或虧損。</p>
                                                                <p>3.3 您確認註冊時提供的資訊是真實和準確的。</p>
                                                                <p>3.4 您同意遵守任何有關法律的規定，就稅務目的而言，包括報告任何交易利潤。</p>
                                                        </div>
                                                </p>
                                                <p>4. 本協議只是就您與本網站之間達成的權利義務關係進行約束，而並不涉及本網站用戶之間與其他網站和您之間因數位資產交易而產生的法律關係及法律糾紛。</p>
                                                <p>5. KTrade為配合市場變動、政策規範、新聞事件等因素，保留不時修訂本協議並以本網站首頁、帳戶總覽內之系統公告進行本協議修改之資訊揭漏，本協議一經網站首頁與系統公告揭漏立即自動生效。</p>
                                                <p>6. 您應不時關注本協議的更新變更時間及更新內容，如您不同意相關變更，應當立即停止使用本網站服務；如您繼續使用本網站服務，即表示您接受並同意經修訂的協議的約束。</p>
                                        </div>
                                        <div>
                                                <h3>二、用戶註冊帳號與安全</h3>
                                                <p>1. 在您註冊成為本網站之用戶前，您已確認並承諾您註冊本網站並非出於違反相關法律、法規或破壞本網站之數位資產交易秩序為目的。</p>
                                                <p>2. 在您完成用戶註冊，或以其他本網站所允許的方式，實際使用本網站提供的相關服務時，您應當是具備可適用的法律規定的可簽署本協定及使用本網站服務應具有的能力的自然人、法人或其他組織。您一旦點擊同意註冊按鈕，即表示您自身或您的有權代理人已經同意該協定內容並由其代理註冊及使用本網站服務。若您不具備前述主體資格，則您及您的有權代理人應承擔因此而導致的一切後果，且本網站保留註銷或永久凍結您的帳戶號碼，並有權向您及您的有權代理人追究相關法律責任。</p>
                                                <p>3. 在您進行註冊啟用成為本網站之用戶(以下簡稱「 KTrade 帳戶」)，與進行本網站設置KYC之安全驗證過程中，您將被要求提供某些個人資訊，包括但不限於您的電話號碼、電子信箱地址、姓名、身分證字號、銀行帳戶、出生日期，並且建立您的帳戶號碼和密碼。您於KTrade 服務的使用權限(包括但不限於發送與提領數位資產之價值限制)係依KTrade之裁量而調整。</p>
                                                <p>4. 如您於註冊成為本網站用戶後，若您具更改您的個人資訊之事實時(包括但不限於姓名、電話號碼、銀行帳戶等事項)，您應更新註冊時提交之資料，以符合及時、詳盡、準確的要求。</p>
                                                <p>5. 如您所在主權國家或地區的法律法規、規則、命令等規範對電話號碼有實名要求，您同意提供註冊的手機號碼是經過實名登記的，如您不按照規定提供，而致使您有任何直接或間接之損失與不利之後果，均應由您自行承擔負責。</p>
                                                <p>6. 透過啟用您的KTrade 帳戶 或使用KTrade 服務和本網站，您即同意：
                                                        <div class="indentTwo">
                                                                <p>6.1 提供有關您的正確、最新和完整的資訊，並及時更新該資訊，以保持其正確、最新和完整。</p>
                                                                <p>6.2 保持身分證明的安全性。</p>
                                                                <p>6.3 接受由於不正確、過時或不完整的資訊所導致的所有風險。</p>
                                                                <p>6.4 對KTrade及其合作關係企業（為您與處理關於法定貨幣的第三方支付處理者），不可撤回地授予關於您KTrade帳戶的個人資訊及其他資訊之存取權(包括但不限於您的交易指示與紀錄，以及您的銀行帳戶資訊。</p>
                                                        </div>
                                                </p>
                                                <p>7. 您的KTrade帳戶將包含下列內容：
                                                        <div class="indentTwo">
                                                                <p>7.1 KTrade將提供您一個數位資產錢包(本網站顯示為「我的錢包」，以下簡稱「數位資產錢包」)，該錢包會依據您的所在國家地區位置以及KTrade之裁量以提供特定之數位資產的相關功能。</p>
                                                                <p>7.2 根據您所在的國家地區位置，提供您線上充值交易預備金額(以下簡稱「交易預備金額」)，其形式包括但不限於平台支援之數位資產種類，如比特幣、以太幣、瑞波幣等加密貨幣，以直到您有進一步的指示操作，但其運作指示仍應依循本使用條款之範疇內。</p>
                                                        </div>
                                                </p>
                                                <p>8. 您將特此授權KTrade可直接或透過第三方，包括但不限於司法機構與相關目的事業主管機關可進行基於防止金錢犯罪驗證您的真實身分是否與您註冊 KTrade 帳戶所提供之資料相符，並可根據該查詢即報告之成果，採取合理且必要之措施。</p>
                                                <p>9. 為維護本網站提供之服務秩序等相關事項，KTrade具備以下之權利與義務：
                                                        <div class="indentTwo">
                                                                <p>9.1 拒絕您註冊或啟用 KTrade 服務和本網站。</p>
                                                                <p>9.2 限制單一用戶可以建立或維護的帳戶數量。</p>
                                                                <p>9.3 倘若 KTrade 發現您疑似有違反本使用條款或其他不正當之行為時，暫停、限制或停止您使用任何或所有KTrade服務和/或本網站。</p>
                                                                <p>如發生下列情事，KTrade將停用或取消您的KTrade 帳戶：
                                                                        <div class="indentFour">
                                                                                <p>9.4.1 若您在註冊過程中或之後所提供之任何資訊非屬正確、最新或完整。</p>
                                                                                <p>9.4.2 若您 KTrade 帳戶活動與行為，被KTrade 認定已違反本使用條款、其他您與KTrade 間的協議、或被KTrade 認定您從事侵害本網站之服務內容與KTrade商譽之相關情事，甚是入侵KTrade相關網站(包括但不限於KTrade官方網站(https://www.ktrade-official.com/ )、本網站與系統內部等非公開可存取之網路區域)。</p>
                                                                                <p>9.4.3 當您使用本網站之服務與KTrade發生爭執等情事並進入司法調查程序，將被KTrade認定與您已無繼續交易之信賴基礎原則。</p>
                                                                                <p>9.4.4 您的KTrade帳戶具有被認定進行違反刑事或法律之情事(包括但不限於詐欺、詐騙、違反反洗錢與反恐怖主義等相關法律規定)。</p>
                                                                        </div>
                                                                </p>
                                                                <p>9.5 本網站通過技術檢測、人工抽檢等檢測方式合理懷疑您提供的資訊錯誤、不實、失效或不完整時，有權通知您更正、更新資訊或中止、終止為其提供本網站服務。</p>
                                                                <p>9.6 本網站有權在發現本網站上顯示的任何資訊存在明顯錯誤時，對資訊予以更正。</p>
                                                                <p>9.7 本網站保留隨時修改、中止或終止本網站服務的權利，本網站行使修改或中止服務的權利不需事先告知您；本網站終止本網站一項或多項服務的，終止自本網站在網站上發佈終止公告之日生效。</p>
                                                                <p>9.8 本網站通過加強技術投入、提升安全防範等措施保障您的數位資產的安全，有義務在您帳戶出現可以預見的安全風險時提前通知您。</p>
                                                                <p>9.9 本網站有權根據您所屬主權國家或地區的法律法規、規則、命令等規範的要求，向您要求提供更多的資訊或資料等，並採取合理的措施，以符合當地的規範之要求，您有義務配合。本網站有權根據您所屬主權國家或地區的法律法規、規則、命令等規範的要求，暫停或永久停止對您的開放本網站及其部分或全部服務。</p>
                                                        </div>
                                                </p>
                                        </div>
                                        <div>
                                                <h3>三、服務內容</h3>
                                                <p>1. 本網站只為您通過註冊KTrade帳戶後於本網站進行數位資產交易活動提供網路交易平臺服務（包括但不限於數位資產交易等服務）。</p>
                                                <p>2. 您有權在本網站流覽數位資產各項產品的即時行情及交易資訊。</p>
                                                <p>3. 您有權通過本網站提交數位資產交易指令並完成數位資產交易。</p>
                                                <p>4. 您有權按照本網站發佈的活動規則參與本網站組織的網站活動。</p>
                                                <p>5. 本網站承諾為您提供的本使用條款範疇內規定之服務。</p>
                                        </div>
                                        <div>
                                                <h3>四、服務與產品規則 </h3>
                                                <p>1. 您承諾遵守本網站所列以下之服務規則：
                                                        <div class="indentTwo">
                                                                <p>1.1 您應當遵守所在國家地區之法律法規、規章、及政策要求等規定，保證帳戶中所有數位資產來源的合法性，不得在本網站或利用本網站服務從事非法或其他損害本網站或合作關係企業權益的活動(包括但不限於發送或接收任何違法、違規、侵犯他人權益的資訊，發送或接收其他具有危害的資訊或言論，或未經本網站授權使用或偽造本網站電子郵件標題之資訊等。)。</p>
                                                                <p>1.2 您應當遵守法律法規，並妥善使用和保管您於本網站之帳戶號碼與登陸密碼、資金密碼、和其註冊時綁定的手機號碼、以及手機接收的手機驗證碼的安全。您對使用其本網站帳號和登陸密碼、資金密碼、手機驗證碼進行的任何操作和後果承擔全部責任。當您發現本網站帳號、登陸密碼、或資金密碼、驗證碼被未經其授權的協力廠商使用，或存在其他帳號安全問題時，應立即有效通知本網站，要求本網站暫停本網站帳號的服務。本網站有權在合理時間內對您的該等請求採取行動，但本網站對在採取行動前已經產生的後果（包括但不限於您的任何損失）不承擔任何責任。您在未經本網站同意的情況下不得將本網站帳號以贈與、借用、租用、轉讓或其他方式處分給他人。</p>
                                                                <p>1.3 您同意您對您的本網站的帳號、密碼下發生的所有活動（包括但不限於資訊揭露、發佈資訊、本網站上點擊同意或提交各類規則協議、本網站上續簽協議等）承擔責任。</p>
                                                                <p>1.4 您在本網站進行數位資產交易時：
                                                                        <div class="indentFour">
                                                                                <p>1.4.1 不得惡意干擾數位資產交易的正常進行、破壞交易秩序</p>
                                                                                <p>1.4.2 不得以任何技術手段或其他方式干擾本網站的正常運行或干擾其他使用者對本網站服務的使用</p>
                                                                                <p>1.4.3 不得以虛構事實等方式，於各社群網站、通訊軟體公開並惡意詆毀本網站的商譽。</p>
                                                                        </div>
                                                                </p>
                                                                <p>1.5 如您因於本網站上交易時與其他使用者產生糾紛的，不得通過司法或行政以外的途徑要求本網站提供相關資料。</p>
                                                                <p>1.6 您在使用本網站提供的服務過程中，所產生的應納稅賦，以及一切硬體、軟體、服務及其它方面的費用，均由您獨自承擔。</p>
                                                                <p>1.7 您應當遵守本網站不時發佈和更新的服務條款和操作規則，並且有權隨時終止使用本網站所提供之服務。</p>
                                                        </div>
                                                </p>
                                                <p>2.幣幣交易產品規則
                                                        <div class="indentTwo">
                                                                <p>2.1 您承諾在進入本網站與其他使用者進行幣幣交易的過程中，遵守良好的交易規則，您可使用之功能包括但不限於：
                                                                        <div class="indentFour">
                                                                                <p>2.1.1 流覽交易資訊：您在本網站流覽幣幣交易資訊時，應當仔細閱讀交易資訊中包含的全部內容，包括但不限於價格、委託量、交易量、手續費、買入或賣出交易區、漲跌幅， 您完全接受交易資訊中包含的全部內容後方可點擊按鈕進行交易。</p>
                                                                                <p>2.1.2 查看您的KTrade帳戶：您可以於帳戶總覽頁面，檢視您於本網站的數位資產(包括但不限於各幣別之總金額、可用總金額、手續費)，並且本網站就上述該值換算為法定貨幣以利您檢視。</p>
                                                                                <p>2.1.3 發送數位資產：您可以於帳戶總覽內的我的錢包，進行提領或發送您的數位資產。</p>
                                                                                <p>2.1.4 接收數位資產：您可以於帳戶總覽內的我的錢包，進行充值或接收您的數位資產。</p>
                                                                                <p>2.1.5 站內發送您的數位資產：本網站提供用戶相互發送彼此之數位資產功能，您使用此功能發送將無須花費額外之轉帳費用(礦工費)。</p>
                                                                                <p>2.1.6 提交委託：在流覽完交易資訊確認無誤，以及您的數位資產是否足夠買賣交易之後，您可以提交買或賣之交易委託。</p>
                                                                                <p>2.1.7 查看委託掛單簿：在您提交交易委託後，即您授權本網站代理您進行相應的交易撮合，本網站在有滿足您委託價格的交易時將會自動完成撮合交易而無需提前通知您，在達成交易之前，您可於掛單簿中檢視您與其他人的交易委託。此外，您也可以於委託中或已成交的，檢視您的交易狀態。</p>
                                                                                <p>2.1.8 查看交易紀錄：您可以通過帳戶總覽內-我的委託-查看相應的委託、已成交以及歷史委託記錄，確認自己的歷史詳情記錄。</p>
                                                                                <p>2.1.9 撤銷/修改委託：在委託未達成交易之前，您有權隨時撤銷或修改委託。</p>
                                                                        </div>
                                                                </p>
                                                        </div>
                                                </p>
                                        </div>
                                        <div>
                                                <h3>五、賠償</h3>
                                                <p>1. 在任何情況下，本網站對您的直接損害的賠償責任均不會超過您從使用本網站服務產生的為期三個月的總費用。</p>
                                                <p>2. 如您發生違反本協議或其他法律法規等情況，您須向本網站至少賠償200萬美元及承擔由此產生的全部費用（包括律師費等），如不夠彌補實際損失，您須補全。</p>
                                        </div>

                                        <div>
                                                <h3>六、尋求禁令救濟的權利</h3>
                                                <p>
                                                        本網站和您均承認普通法對違約或可能違約情況的救濟措施是可能是不足以彌補本網站遭受的全部損失的，故非違約方有權在違約或可能違約情況下尋求禁令救濟以及普通法或衡平法允許的其他所有的補救措施。
                                                </p>
                                        </div>
                                        <div>
                                                <h2>七、責任限制與免責</h2>
                                                <p>1. 您瞭解並同意，在任何情況下，本網站不就以下各事項承擔責任：
                                                        <div class="indentTwo">
                                                                <p>1.1 收入的損失；</p>
                                                                <p>1.2 交易利潤或合同損失；</p>
                                                                <p>1.3 業務中斷；</p>
                                                                <p>1.4 預期可節省的貨幣的損失；</p>
                                                                <p>1.5 資訊的損失；</p>
                                                                <p>1.6 機會、商譽或聲譽的損失；</p>
                                                                <p>1.7 資料的損壞或損失；</p>
                                                                <p>1.8 購買替代產品或服務的成本；</p>
                                                                <p>1.9 任何由於侵權（包括過失）、違約或其他任何原因產生的間接的、特殊的或附帶性的損失或損害，不論這種損失或損害是否可以為本網站合理預見；不論本網站是否事先被告知存在此種損 失或損害的可能性。</p>
                                                                <p>7.1.1 條至7.1.9條均是彼此獨立的。</p>
                                                        </div>
                                                </p>
                                                <p>2. 您瞭解並同意，本網站不對因下述任一情況而導致您的任何損害賠償承擔責任：
                                                        <div class="indentTwo">
                                                                <p>1.1 本網站有合理的理由認為您的具體交易事項可能存在重大違法或違約情形。</p>
                                                                <p>1.2 本網站有合理的理由認為您在本網站的行為涉嫌違法或不當。</p>
                                                                <p>1.3 通過本網站服務購買或獲取任何資料、資訊或進行交易等行為或替代行為產生的費用及損失。</p>
                                                                <p>1.4 您對本網站服務的誤解。</p>
                                                                <p>1.5 任何非因本網站的原因而引起的與本網站提供的服務有關的其它損失。</p>
                                                        </div>
                                                </p>
                                                <p>3. 本網站對由於資訊網路設備維護、資訊網路連接故障、電腦、通訊或其他系統的故障、電力故障、天氣原因、意外事故、罷工、勞動爭議、暴亂、起義、騷亂、生產力或生產資料不足、火災、洪水、風暴、爆炸、戰爭、銀行或其他合作方原因、數位資產市場崩潰、政府行為、 司法或行政機關的命令、其他不在本網站可控範圍內或本網站無能力控制的行為或協力廠商的原因而造成的不能服務或延遲服務，以及造成的您的損失，本網站不承擔任何責任。</p>
                                                <p>4. 本網站不能保證本網站包含的全部資訊、程式、文本等完全安全，不受任何病毒、木馬等惡意程式的干擾和破壞，故您登陸、使用本網站任何服務或下載及使用該下載的任何程式、資訊、資料等均是您個人的決定並自行承擔風險及可能產生的損失。</p>
                                                <p>5. 本網站對本網站中連結的任何協力廠商網站的任何資訊、產品及業務及其他任何形式的不屬於本網站的主體的內容等不做任何保證和承諾，您如果使用協力廠商網站提供的任何服務、資訊及產品等均為您個人決定且承擔由此產生的一切責任。</p>
                                                <p>6. 本網站對於您使用本網站服務不做任何明示或暗示的保證，包括但不限於本網站提供服務的適用性、沒有錯誤或疏漏、持續性、準確性、可靠性、適用於某一特定用途。同時，本網站也不對本網站提供的服務所涉及的技術及資訊的有效性、準確性、正確性、可靠性、品質、穩定、完整和及時性作出任何承諾和保證。是否登陸或使用本網站提供的服務是您個人的決定且自行承擔風險及可能產生的損失。本網站對於數位資產的市場、價值及價格等不做任何明示或暗示的保證，您理解並瞭解數位資產市場是不穩定的，價格和價值隨時會大幅波動或崩盤，交易數位資產是您個人的自由選擇及決定且自行承擔風險及可能產生的損失。</p>
                                                <p>7. 本協議中規定的本網站的保證和承諾是由本網站就本協議和本網站提供的服務的唯一保證和陳述，並取代任何其他途徑和方式產生的保證和承諾，無論是書面的或口頭的，​​明示的或暗示的。所有這些保證和陳述僅僅代表本網站自身的承諾和保證，並不保證任何協力廠商遵守本協議中的保證和承諾。</p>
                                                <p>8. 本網站並不放棄本協議中未提及的在法律適用的最大範圍內本網站享有的限制、免除或抵銷本網站損害賠償責任的任何權利。</p>
                                                <p>9. 您註冊後即表示認可本網站按照本協定中規定的規則進行的任何操作，產生的任何風險均由您承擔。</p>
                                        </div>
                                        <div>
                                                <h3>八、協議的終止</h3>
                                                <p>1. 本網站有權依據本協議約定登出您的本網站帳號，本協議於帳號登出之日終止。</p>
                                                <p>2. 本網站有權依據本協定約定終止全部本網站服務，本協定於本網站全部服務終止之日終止。</p>
                                                <p>3. 本協議終止後，您無權要求本網站繼續向其提供任何服務或履行任何其他義務，包括但不限於要求本網站為您保留或向您披露其原本網站帳號中的任何資訊， 向您或協力廠商轉發任何其未曾閱讀或發送過的資訊等。</p>
                                                <p>4. 本協議的終止不影響守約方向違約方要求其他責任的承擔。</p>
                                        </div>
                                        <div>
                                                <h3>九、智慧財產權</h3>
                                                <p>1. 本網站所包含的全部智力成果包括但不限於網站標誌、資料庫、網站設計、文字和圖表、軟體、照片、錄影、音樂、聲音及其前述組合，軟體編譯、相關原始程式碼和軟體 (包括小應用程式和腳本) 的智慧財產權權利均歸本網站所有。您不得為商業目的複製、更改、拷貝、發送或使用前述任何材料或內容。</p>
                                                <p>2. 本網站名稱中包含的所有權利 (包括但不限於商譽和商標、標誌) 均歸公司所有。</p>
                                                <p>3. 您接受本協議即視為您主動將其在本網站發表的任何形式的資訊的著作權， 包括但不限於：複製權、發行權、出租權、展覽權、表演權、放映權、廣播權、資訊網路傳播權、攝製權、改編權、翻譯權、彙編權 以及應當由著作權人享有的其他可轉讓權利無償獨家轉讓給本網站所有，本網站有權利就任何主體侵權單獨提起訴訟並獲得全部賠償。 本協議效力及於您在本網站發佈的任何受著作權法保護的作品內容， 無論該內容形成於本協定簽訂前還是本協定簽訂後。</p>
                                                <p>4. 您在使用本網站服務過程中不得非法使用或處分本網站或他人的智慧財產權權利。您不得將已發表於本網站的資訊以任何形式發佈或授權其它網站（及媒體）使用。</p>
                                                <p>5. 您登陸本網站或使用本網站提供的任何服務均不視為本網站向您轉讓任何智慧財產權。</p>
                                        </div>
                                        <div>
                                                <h3>十、免責聲明</h3>
                                                <p>1. KTrade服務、本網站以及此處提供的內容可能包含某些尚未被辨識的問題。KTrade服務、本網站及內容是以其「現有」狀態而提供。建議您謹慎地使用KTrade服務、本網站以及內容，並為必要之查證和判斷，且您不可以完全倚賴KTrade服務、本網站以及內容及其附隨的指示或資料。KTrade 不保證將永久提供KTrade服務、本網站和內容（包括但不限於KTrade服務及本網站的全部或任何特定期間的特定功能）。對於任何KTrade服務、本網站及內容的事項、修改或改善，KTrade不做出任何保證。KTrade在此特別聲明不提供任何默示的保證。</p>
                                                <p>2. 無論是自KTrade、KTrade服務、本網站或內容所獲取的任何口頭或書面的建議或資訊，都無法創造未在這裡明示的任何保證。您應對您所有交易或持有數位資產一事自行負擔全部責任。</p>
                                                <p>3. 上述免責聲明應在法律允許的最大範圍下適用，並且在本使用條款終止或失效後，或在用戶終止使用KTrade服務和本網站或該使用失效後，仍繼續適用。</p>
                                        </div>
                                        <div>
                                                <h3>十一、司法管轄權</h3>
                                                <p>本使用條款之效力、解釋、適用及爭議解決，均應以中華民國台灣法律為準據法，並依該法解釋（包括但不限於本使用條款的有效性、解釋、結構、履行和執行，或由本使用條款所生或與之相關的任何紛爭或爭議）。任何因本使用條款所生之相關爭議、紛爭等，應以臺北地方法院為唯一第一審之管轄法院。</p>
                                        </div>
                                        <div>
                                                <h3>十二、其他</h3>
                                                <p><span>1. 可分割性</span><br /><span>如本協議中的任何條款被任何有管轄權的法院認定為不可執行的，無效的或非法的，並不影響本協議的其餘條款的效力。</span></p>
                                                <p><span>2. 非代理關係</span><br /><span>本協議中的任何規定均不可被認為創造了、暗示了或以其他方式將本網站視為您的代理人、受託人或其他代表人，本協議有其他規定的除外。</span></p>
                                                <p><span>3. 棄權</span><br /><span>本網站或您任何一方對追究本協議約定的違約責任或其他責任的棄權並不能認定或解釋為對其他違約責任的棄權；未行使任何權利或救濟不得以任何方式被解釋為對該等權利或救濟的放棄。</span></p>
                                                <p><span>4. 標題</span><br /><span>所有標題僅供協議表述方便，並不用於擴大或限制該協定條款的內容或範圍。</span></p>
                                        </div>
                                        <div>
                                                <h3>十三、協議的生效和解釋</h3>
                                                <p>1. 本協議於您點擊本網站註冊頁面的同意註冊並完成註冊程序、獲得本網站帳號和密碼時生效，對本網站和您均具有約束力。</p>
                                                <p>2. 本協議的最終解釋權歸本網站所有。</p>
                                        </div>

                                </div>
                        </div>
                </div>
            """

}

