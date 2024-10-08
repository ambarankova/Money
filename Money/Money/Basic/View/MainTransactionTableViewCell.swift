//
//  ExpensesTableViewCell.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import SnapKit
import UIKit

final class MainTransactionTableViewCell: UITableViewCell {
    // MARK: - GUI Variables
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 5
        
        return view
    }()
    
    private lazy var categoryLabel = createLabel(font: .boldSystemFont(ofSize: Constants.Sizes.textSize),
                                                 aligment: .left,
                                                 text: "Food")
    private lazy var planLabel = createLabel(font: .systemFont(ofSize: Constants.Sizes.textSize),
                                             text: "100")
    private lazy var factLabel = createLabel(font: .systemFont(ofSize: Constants.Sizes.textSize),
                                             text: "20")
    
    // MARK: - Properties
    static let reuseID = "MainTransactionTableViewCell"
    
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
    func configure(with transaction: TransactionObject) {
        categoryLabel.text = transaction.category
        
        let defaultPlanText = Constants.Texts.defaultPlan
        let defaultFactText = Constants.Texts.defautFact
        
        if let plan = transaction.plan {
            planLabel.text = String(plan)
        } else {
            planLabel.text = defaultPlanText
        }
        
        if let fact = transaction.fact {
            factLabel.text = String(fact)
        } else {
            factLabel.text = defaultFactText
        }
    }
}

// MARK: - Private 
private extension MainTransactionTableViewCell {
    func setupUI() {
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

// MARK: - UI constants
private extension MainTransactionTableViewCell {
    enum Constants {
        enum Texts {
            static let defaultPlan = "Plan".localized
            static let defautFact = "Fact".localized
        }
        enum Sizes {
            static let textSize: CGFloat = 17
        }
    }
}
