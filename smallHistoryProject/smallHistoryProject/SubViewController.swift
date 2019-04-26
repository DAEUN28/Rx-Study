//
//  SubViewController.swift
//  smallHistoryProject
//
//  Created by baby1234 on 24/04/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SubViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.selectedName.bind(to: nameLbl.rx.text).disposed(by: disposeBag)
    }

    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
