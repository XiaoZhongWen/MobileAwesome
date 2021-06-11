//
//  ContactCell.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/11.
//

import UIKit
import SnapKit

class ContactCell: UITableViewCell {
    private let headerView: UIImageView
    private let nameLabel: UILabel
    private let summaryLabel: UILabel

    static let identifier = String.init(NSStringFromClass(ContactCell.self))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        headerView = UIImageView.init(image: UIImage.init(named: "contact_default"))
        nameLabel = UILabel.init()
        summaryLabel = UILabel.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.font = UIFont.systemFont(ofSize: FontSize_Level_4)
        nameLabel.textColor = UIColor.black

        summaryLabel.font = UIFont.systemFont(ofSize: FontSize_Level_2)
        summaryLabel.textColor = TextGrayColor

        self.contentView.addSubview(headerView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(summaryLabel)

        headerView.snp_makeConstraints { make in
            make.left.equalTo(self.contentView).offset(Default_Margin)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize.init(width: Contact_Header_Size, height: Contact_Header_Size))
        }

        nameLabel.snp_makeConstraints { make in
            make.top.equalTo(headerView)
            make.left.equalTo(headerView.snp_right).offset(Default_Margin)
            make.right.equalTo(self.contentView).offset(-Default_Margin)
        }

        summaryLabel.snp_makeConstraints { make in
            make.bottom.equalTo(self.contentView)
            make.left.equalTo(headerView.snp_right).offset(Default_Margin)
            make.right.equalTo(self.contentView).offset(-Default_Margin)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
