//
//  DemoCell.swift
//  Trofi
//
//  Created by Dhrumil Shah on 2017-07-22.
//  Copyright © 2017 makeschool. All rights reserved.
//

import UIKit
import FoldingCell

class DemoCell: FoldingCell {
    
    @IBOutlet weak var closeNumberLabel: UIImageView!
    @IBOutlet weak var openNumberLabel: UILabel!

    var number: Int = 0 {
        didSet {
            openNumberLabel.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }

}

// MARK: - Actions
extension DemoCell {
    @IBAction func buttonHandler(_ sender: AnyObject) {
        print("tap")
    }
    
}
