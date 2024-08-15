//
//  ExpensesTableViewCell.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

final class ExpensesTableViewCell: UITableViewCell {

    // MARK: - GUI Variables

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 5
        return view
    }()
    
    private lazy var categoryLabel = createLabel(font: .boldSystemFont(ofSize: textSize),
                                                 aligment: .left,
                                                 text: "Food")
    private lazy var planLabel = createLabel(font: .systemFont(ofSize: textSize),
                                             text: "100")
    private lazy var factLabel = createLabel(font: .systemFont(ofSize: textSize),
                                             text: "20")
    
    // MARK: - Properties
    static let reuseID = "ExpensesTableViewCell"
    private let textSize: CGFloat = 17
    
    // MARK: - Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func configure(with expense: ExpensesObject) {
        categoryLabel.text = expense.category

        let defaultPlanText = "Plan"
        let defaultFactText = "Fact"

        // Проверим значения что они не nil.
        // map преобразует в строку, если значение не nil. Иначе поставим значение по умолчанию
        planLabel.text = expense.plan.map(String.init) ?? defaultPlanText
        factLabel.text = expense.fact.map(String.init) ?? defaultFactText
    }
}

// MARK: - Private Methods

private extension ExpensesTableViewCell {

    func setupUI() {
        // добавляем элементы в contentView ячейки, иначе они будут добавлены поверх нее
        contentView.addSubview(stackView)
        [categoryLabel, planLabel, factLabel].forEach { stackView.addArrangedSubview($0) }
        setupConstraints()
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
    }

    func createLabel(font: UIFont?,
                     aligment: NSTextAlignment? = nil,
                     color: UIColor? = nil,
                     text: String,
                     background: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.textAlignment = aligment ?? .center
        return label
    }
}
