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
    
    // MARK: - Properties
    private let textSize: CGFloat = 17
    
    private lazy var categoryLabel = createLabel(font: .boldSystemFont(ofSize: textSize),aligment: .left, text: "Food")
    private lazy var planLabel = createLabel(font: .systemFont(ofSize: textSize), text: "100")
    private lazy var factLabel = createLabel(font: .systemFont(ofSize: textSize), text: "20")
    
    // MARK: - Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(expense: ExpensesTableViewCellViewModel) {
        categoryLabel = createLabel(font: .boldSystemFont(ofSize: 15),aligment: .left, text: expense.name)
        planLabel = createLabel(font: .systemFont(ofSize: 15), text: String(expense.plan))
        factLabel = createLabel(font: .systemFont(ofSize: 15), text: String(expense.fact))
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(stackView)
        [categoryLabel, planLabel, factLabel].forEach { stackView.addArrangedSubview($0) }
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func createLabel(font: UIFont,
                             aligment: NSTextAlignment? = nil,
                             color: UIColor? = nil,
                             text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.textAlignment = aligment ?? .center
        return label
    }
}
