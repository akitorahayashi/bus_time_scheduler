//
//  CardButton.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

// tableViewを反転
// cellも反転
// 後どのくらいか
// 後何分でここを出なければいけないのか
// 後何分に家につきたいのか
// 何分に家に着くならこの時間がいい -> Yahooの乗換案内

import UIKit

class CardButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.backgroundColor = .white
        self.setTitleColor(.accent, for: .normal)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.accent.cgColor
        self.layer.cornerRadius = 10
    }
}
