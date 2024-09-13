//
//  ExpensesViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

final class ExpensesViewController: UIViewController {
    // MARK: - GUI Variables
    private let table = UITableView()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.countLabelText
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.monthLabelText
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Properties
    private var viewModel: ExpensesViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: ExpensesViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
        registerObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private
private extension ExpensesViewController {
    func setupViewModel() {
        viewModel?.reloadTable = { [weak self] in
            self?.table.reloadData()
        }
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("Update"), object: nil)
    }
    
    @objc private func updateData() {
        table.reloadData()
    }
    
    private func setupTableView() {
        table.register(ExpensesTableViewCell.self, forCellReuseIdentifier: ExpensesTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
    }
    
    func setupUI() {
        [countLabel, monthLabel, table].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        let countInt = viewModel?.count ?? 0
        countLabel.text = String(countInt)
        
        if countInt < 0 {
            monthLabel.text = "your minus in this month"
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
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
    }
}

// MARK: - UITableViewDelegate
extension ExpensesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 && (indexPath.section + 1) != viewModel?.sections.count {
            guard let category = viewModel?.sections[indexPath.section].items[indexPath.row].category else { return }
            
            let alertController = UIAlertController(title: "Change plan", message: nil, preferredStyle: .alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = "New plan value"
                textField.keyboardType = .numberPad
            }
            
            let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
                if let newPlanText = alertController.textFields?.first?.text,
                   let newPlan = Float(newPlanText) {
                    self.viewModel?.changePlan(newPlan, category)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSourse
extension ExpensesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesTableViewCell.reuseID,
                                                       for: indexPath) as? ExpensesTableViewCell else {
            return UITableViewCell()
        }
        if let expense = viewModel?.sections[indexPath.section].items[indexPath.row] as? ExpensesObject {
            cell.configure(with: expense)
        }
        return cell
    }
}

// MARK: - UI constants
private extension ExpensesViewController {
    enum Constants {
        enum Texts {
            static let countLabelText = "Count"
            static let monthLabelText = "you still can spend this month"
        }
        enum Sizes {
        }
    }
}
