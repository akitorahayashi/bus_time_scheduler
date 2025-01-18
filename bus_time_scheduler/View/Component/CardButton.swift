//
//  CardButton.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

// 何分に家につきたいのか
// 何分に家に着くならこの時間がいい -> Yahooの乗換案内

import UIKit

class CardButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.backgroundColor = .white
        self.setTitleColor(.accent, for: .normal)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.accent.cgColor
        self.layer.cornerRadius = 10
    }
    
    // タップ時に薄くなる視覚効果
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }
}
