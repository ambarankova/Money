import UIKit
import SnapKit

protocol AddExpensesViewControllerDelegate: AnyObject {
    func didAddExpense(_ expense: TransactionObject)
}

final class AddExpensesViewController: UIViewController {
    // MARK: - GUI Elements
    private lazy var categoryTextField = createTextField(text: Constants.Texts.selectText)
    
    private lazy var amountTextField = createTextField(text: Constants.Texts.amountText)
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .date
        
        return picker
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.Sizes.buttonText)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = CGFloat(Constants.Sizes.buttonHeight / 2)
        
        button.setTitle(Constants.Texts.saveButtonText, for: .normal)
        button.addTarget(nil, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let categoryPickerView = UIPickerView()
    
    // MARK: - Properties
    private var selectedCategory: String?
    private let dateFormatter = DateFormatter()
    private let categories = Categories().categoriesExpense
    
    weak var delegate: AddExpensesViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPickerView()
    }
}

// MARK: - Private
private extension AddExpensesViewController {
    @objc func saveButtonTapped() {
        guard let category = selectedCategory,
              let amountText = amountTextField.text,
              let amount = Float(amountText) else { return }
        let date = datePicker.date
        
        let expense = TransactionObject(category: category, date: date, plan: amount, fact: amount)
        
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
        
        delegate?.didAddExpense(expense)
        dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        [categoryTextField, amountTextField, datePicker, saveButton].forEach { view.addSubview($0) }
        setupConstraints()
    }
    
    func setupConstraints() {
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.height.equalTo(Constants.Sizes.buttonHeight)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(20)
            make.height.equalTo(Constants.Sizes.buttonHeight)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.Sizes.buttonHeight)
            make.width.equalTo(Constants.Sizes.buttonWidth)
        }
    }
    
    func setupPickerView() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
    }
    
    func createTextField(text: String) -> UITextField {
        let textField = UITextField()

        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        
        textField.placeholder = text
        let placeholderColor = UIColor.gray
        let placeholderFont = UIFont.systemFont(ofSize: Constants.Sizes.buttonText)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: placeholderFont
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
        
        textField.frame = CGRect(x: 50, y: 100, width: 200, height: 40)
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.leftViewMode = .always
        
        return textField
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension AddExpensesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

// MARK: - UI constants
private extension AddExpensesViewController {
    enum Constants {
        enum Texts {
            static let saveButtonText = "Save"
            static let selectText = "Select category"
            static let amountText = "Amount"
        }
        enum Sizes {
            static let buttonText: CGFloat = 17
            static let buttonHeight: CGFloat = 50.0
            static let buttonWidth: CGFloat = 150.0
        }
    }
}
