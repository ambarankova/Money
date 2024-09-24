//
//  AddIncomeViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 24.09.2024.
//

import UIKit
import SnapKit

protocol AddIncomeViewControllerDelegate: AnyObject {
    func didAddIncome(_ income: TransactionObject)
}

final class AddIncomeViewController: UIViewController {

    // MARK: - Properties
    let categories = Categories().categoriesIncome
    private var selectedCategory: String?
    private let dateFormatter = DateFormatter()

    weak var delegate: AddIncomeViewControllerDelegate?

    // MARK: - GUI Elements
    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Category"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .date
        
        return picker
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(nil, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private let categoryPickerView = UIPickerView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPickerView()
    }
}

// MARK: - Private
private extension AddIncomeViewController {
    @objc func saveButtonTapped() {
        guard let category = selectedCategory,
              let amountText = amountTextField.text,
              let amount = Float(amountText) else { return }
        let date = datePicker.date
        
        let income = TransactionObject(category: category, plan: amount, fact: amount, date: date)
        delegate?.didAddIncome(income)
        dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = .white

        [categoryTextField, amountTextField, datePicker, saveButton].forEach { view.addSubview($0) }
        setupConstraints()
    }

    func setupConstraints() {
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    func setupPickerView() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
        categoryTextField.tintColor = .clear
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension AddIncomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        categoryTextField.text = selectedCategory
    }
}
