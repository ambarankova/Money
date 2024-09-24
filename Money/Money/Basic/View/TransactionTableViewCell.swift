//
//  ExpTransactionTableViewCell.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {
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
    private lazy var factLabel = createLabel(font: .systemFont(ofSize: textSize),
                                             text: "100")
    private lazy var dateLabel = createLabel(font: .systemFont(ofSize: textSize),
                                             text: "20 apr 24")
    
    // MARK: - Properties
    static let reuseID = "TransactionTableViewCell"
    private let textSize: CGFloat = 17
    private let dateFormatter = DateFormatter()
    
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

        let defaultFactText = "Fact"
        let defaultDateText = "Date"
        dateFormatter.dateFormat = "dd MMM yyyy"

        if let fact = transaction.fact {
            factLabel.text = String(fact)
        } else {
            factLabel.text = defaultFactText
        }
        
        if let date = transaction.date {
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = defaultDateText
        }
    }
}

// MARK: - Private Methods
private extension TransactionTableViewCell {
    func setupUI() {
        contentView.addSubview(stackView)
        [categoryLabel, factLabel, dateLabel].forEach { stackView.addArrangedSubview($0) }
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