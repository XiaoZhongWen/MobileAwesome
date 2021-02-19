//
//  ZXWorkController.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/9.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

import BaseLibrary

class ZXWorkController: ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let list = MessageListDao.init().fetchLastestConversation(
            userId: "_group_b3739e3749c74f48a5dae812091ad8fc",
            pageSize: Global_Conversation_Page_Size)
        print(list)
    }
}
