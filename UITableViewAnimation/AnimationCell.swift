//
//  AnimationCell.swift
//  UITableViewAnimation
//
//  Created by Yoichi on 2019/02/23.
//  Copyright © 2019 Yoichi. All rights reserved.
//

import UIKit

class AnimationCell: UITableViewCell {
    
    var toggleButtonTapHandler: (() -> Void)?
    
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet private weak var label2: UILabel!
    @IBOutlet private weak var label3: UILabel!
    @IBOutlet private weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    private lazy var animationLabels: [UILabel] = [label2, label3, label4]
    private var duration: TimeInterval = 0
    
    @IBAction func toggle(_ sender: Any) {
        toggleButtonTapHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(isOpen: Bool, backgroundColor: UIColor, duration: TimeInterval) {
        contentView.backgroundColor = backgroundColor
        self.duration = duration
        refreshTitle(isOpen: isOpen)
        animationLabels.forEach { $0.isHidden = isOpen }
    }
    
    private func refreshTitle(isOpen: Bool) {
        let toggleStr = isOpen ? "▼" : "▲"
        let title = "Duration: \(duration) " + toggleStr
        toggleButton.setTitle(title, for: .normal)
    }
    
    func toggle(isOpen: Bool) {
        refreshTitle(isOpen: isOpen)
        
        /// Ainmation
        let opacity: Float = isOpen ? 0.0 : 1.0
        UIView.animate(withDuration: duration) {
            self.animationLabels.forEach { label in
                label.isHidden = isOpen
                label.layer.opacity = opacity
            }
            self.stackView.layoutIfNeeded()
        }
    }
}
