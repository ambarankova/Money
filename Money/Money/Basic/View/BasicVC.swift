//
//  BasicVC.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import SnapKit
import UIKit

class BasicVC: UIViewController {
    // MARK: - GUI Variables
    var countLabel: UILabel = {
        let label = UILabel()
        
        label.text = Constants.Texts.countLabelText
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        
        return label
    }()
    
    var monthLabel: UILabel = {
        let label = UILabel()
        
        label.text = Constants.Texts.plusMonthLabelText
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(Constants.Texts.buttonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = CGFloat(Constants.Sizes.buttonHeight / 2)
        
        button.addTarget(nil, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let table = UITableView()
    
    // MARK: - Properties
    var viewModel: MainTransactionViewModelProtocol?
    
    // MARK: - Life Cycle
        init(viewModel: MainTransactionViewModelProtocol) {
            self.viewModel = viewModel
    
            super.init(nibName: nil, bundle: nil)
    
            self.setupViewModel()
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        registerObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private
extension BasicVC {
        private func setupViewModel() {
            viewModel?.reloadTable = { [weak self] in
                self?.table.reloadData()
            }
        }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("Update"), object: nil)
    }
    
    private func setupTableView() {
        table.register(MainTransactionTableViewCell.self, forCellReuseIdentifier: MainTransactionTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
    }
    
    private func setupUI() {
        [countLabel, monthLabel, table, clearButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        guard let countInt = viewModel?.count else { return }
        countLabel.text = String(countInt)
        
        if countInt < 0 {
            monthLabel.text = Constants.Texts.minusMonthLabelText
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(10)
            make.height.equalTo(400)
        }
        
        clearButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Sizes.buttonHeight)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }
    
    @objc func clearButtonTapped() { }
    
    @objc private func updateData() {
        table.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension BasicVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 && (indexPath.section + 1) != viewModel?.sections.count {
            guard let category = viewModel?.sections[indexPath.section].items[indexPath.row].category else { return }
            
            let alertController = UIAlertController(title: Constants.Texts.alertTitle, message: nil, preferredStyle: .alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = Constants.Texts.placeholderText
                textField.keyboardType = .numberPad
            }
            
            let confirmAction = UIAlertAction(title: Constants.Texts.confirmationAction, style: .default) { _ in
                if let newPlanText = alertController.textFields?.first?.text,
                   let newPlan = Float(newPlanText) {
                    self.viewModel?.changePlan(newPlan, category)
                }
            }
            
            let cancelAction = UIAlertAction(title: Constants.Texts.cancelAction, style: .cancel, handler: nil)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSourse
extension BasicVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UI constants
private extension BasicVC {
    enum Constants {
        enum Texts {
            static let countLabelText = "Count"
            static let plusMonthLabelText = "keep it up!"
            static let minusMonthLabelText = "keep an eye on the budget"
            static let buttonTitle = "New month"
            static let alertTitle = "Change plan"
            static let placeholderText = "New plan value"
            static let confirmationAction = "OK"
            static let cancelAction = "Cancel"
        }
        enum Sizes {
            static let buttonHeight: CGFloat = 70.0
        }
    }
}

