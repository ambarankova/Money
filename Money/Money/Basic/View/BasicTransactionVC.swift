//
//  BasicTransactionVC.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import SnapKit
import UIKit

class BasicTransactionVC: UIViewController {
    // MARK: - GUI Variables
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = Constants.Texts.titleText
        label.font = .boldSystemFont(ofSize: Constants.Sizes.bigText)
        label.textAlignment = .center
        
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(Constants.Texts.buttonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.Sizes.buttonText)
        button.setTitleColor(.black, for: .normal)
        
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = CGFloat(Constants.Sizes.buttonHeight / 2)
        
        button.addTarget(nil, action: #selector(addButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    var table = UITableView()
    
    // MARK: - Properties
    var viewModel: TransactionViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: TransactionViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.getTransactions()
        viewModel?.reloadTable?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
    }
}

// MARK: - Private
extension BasicTransactionVC {
    func setupViewModel() {
        viewModel?.reloadTable = { [weak self] in
            self?.table.reloadData()
        }
    }
    
    func setupTableView() {
        table.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
    }
    
    func setupUI() {
        [titleLabel, table, plusButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(10)
            make.height.equalTo(400)
        }
        
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.Sizes.buttonHeight)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }
    
    @objc func addButtonTapped() { }
}

// MARK: - UITableViewDelegate
extension BasicTransactionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}

// MARK: - UITableViewDataSourse
extension BasicTransactionVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell",
                                                       for: indexPath) as? TransactionTableViewCell,
              let transaction = viewModel?.sections[indexPath.section].items[indexPath.row] as? TransactionObject
        else { return UITableViewCell() }
        
        cell.configure(with: transaction)
        return cell
    }
}

// MARK: - UI constants
private extension BasicTransactionVC {
    enum Constants {
        enum Texts {
            static let buttonTitle = "+"
            static let titleText = "Transactions".localized
        }
        enum Sizes {
            static let bigText: CGFloat = 50
            static let smallText: CGFloat = 20
            static let buttonText: CGFloat = 30
            static let buttonHeight: CGFloat = 70.0
            static let buttonWidth: CGFloat = 210.0
        }
    }
}
