//
//  ViewController.swift
//  smallHistoryProject
//
//  Created by baby1234 on 19/04/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "HistoryCell")) { row, historicalSite, cell in
                let historyCell = cell as? HistoryCell
                historyCell?.imgView?.kf.setImage(with: URL(string: historicalSite.imagePath))
                historyCell?.imgView.alpha = 0.3
                historyCell?.nameLbl.text = historicalSite.name
                historyCell?.locationLbl.text = historicalSite.location
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind(to: viewModel.selectedIndexPath).disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let subVC = segue.destination as? SubViewController
            subVC?.viewModel = viewModel
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
