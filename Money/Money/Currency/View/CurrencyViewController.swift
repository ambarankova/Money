//
//  CurrencyViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import SnapKit
import UIKit

final class CurrencyViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var dollarTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = Constants.Texts.dollarText
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var dollarLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var rubleTextLabel1: UILabel = {
        let label = UILabel()
        
        label.text = Constants.Texts.rubles
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var euroTextLabel: UILabel = {
        let label = UILabel()

        label.text = Constants.Texts.euroText
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var euroLabel: UILabel = {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var rubleTextLabel2: UILabel = {
        let label = UILabel()
        
        label.text = Constants.Texts.rubles
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Properties
    var viewModel: CurrencyViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: CurrencyViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupUI()
    }
}

// MARK: - Private
private extension CurrencyViewController {
    func setupUI() {
        [dollarLabel, dollarTextLabel, euroLabel, euroTextLabel, rubleTextLabel1, rubleTextLabel2].forEach { view.addSubview($0) }
        view.backgroundColor = .white

        setupConstraints()
    }
    
    func setupConstraints() {
        dollarTextLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.leading.trailing.equalToSuperview()
        }
        
        dollarLabel.snp.makeConstraints { make in
            make.top.equalTo(dollarTextLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        rubleTextLabel1.snp.makeConstraints { make in
            make.top.equalTo(dollarLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        euroTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dollarLabel.snp.bottom).offset(100)
            make.trailing.leading.equalToSuperview()
        }
        
        euroLabel.snp.makeConstraints { make in
            make.top.equalTo(euroTextLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        rubleTextLabel2.snp.makeConstraints { make in
            make.top.equalTo(euroLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setupLabels() {
        dollarLabel.text = viewModel?.dollarPrice
        euroLabel.text = viewModel?.euroPrice
    }
}

// MARK: - UI constants
private extension CurrencyViewController {
    enum Constants {
        enum Texts {
            static let rubles = "rubles".localized
            static let dollarText = "today 1 dollar costs".localized
            static let euroText = "today 1 euro costs".localized
        }
        enum Sizes {
        }
    }
}

