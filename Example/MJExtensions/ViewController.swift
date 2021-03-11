//
//  ViewController.swift
//  MJExtensions
//
//  Created by chenminjie92@126.com on 03/11/2021.
//  Copyright (c) 2021 chenminjie92@126.com. All rights reserved.
//

import UIKit
import MJExtensions
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dic: [String: Any] = ["123":"123","2223":223]
        let list: [[String:Any]] = [dic,dic]
        print(dic.ext.jsonString)
        print(list.ext.jsonString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = UIColor.ext.hex(0x000000, alpha: 0.3)
        view.text = Date().ext.weekDayString
        return view
    }()

}

extension ViewController {
    
    private func setUpViews() {
        view.backgroundColor = UIColor.ext.hex(0xffffff)
        view.addSubview(imageView)
        view.addSubview(timeLabel)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(imageView.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        imageView.ext.setImage(with: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2109617360,2782960381&fm=26&gp=0.jpg")
    }

}

