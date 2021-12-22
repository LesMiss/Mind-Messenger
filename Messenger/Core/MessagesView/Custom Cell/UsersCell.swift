//
//  UsersCell.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import Foundation
import UIKit

class UsersCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width + 100, height: 79.5))
        view.backgroundColor = UIColor.secondarySystemBackground
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 15, y: 15, width: 50, height: 50))
        img.backgroundColor = UIColor.systemBackground
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var title: UILabel = {
       let title = UILabel()
        title.frame = CGRect(x: 80, y: 15, width: 300, height: 20)
        title.textColor = UIColor.dynamic
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return title
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 15, width: self.contentView.frame.width, height: 30)
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        addSubview(imgView)
        addSubview(title)

    }
}
