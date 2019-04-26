//
//  ViewModel.swift
//  smallHistoryProject
//
//  Created by baby1234 on 23/04/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    let selectedIndexPath = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    var selectedName: Observable<String> {
        get {
            return Observable.combineLatest(data.asObservable(), selectedIndexPath.asObservable(), resultSelector: { (data, indexpath) in
                return data[indexpath.row].name })
        }
    }
    
    lazy var data: Driver<[HistoricalSite]> = {
        return ViewModel.getData().asDriver(onErrorJustReturn: [])
    }()
    
    static func getData() -> Observable<[HistoricalSite]> {
        guard let url = URL(string: "http://52.199.207.14/main/bla") else {
                return Observable.just([])
        }
        
        return URLSession.shared.rx.json(url: url)
            .retry(3)
            //.catchErrorJustReturn([])
            .map(parse)
    }
    
    static func parse(json: Any) -> [HistoricalSite] {
        guard let items = json as? [[String: Any]]  else {
            return []
        }
        
        var historicalSites = [HistoricalSite]()
        
        items.forEach{
            guard let siteName = $0["historicalSiteName"] as? String,
                let siteLocation = $0["historicalSiteLocation"] as? String,
                let siteImagePath = $0["historicalSiteImagePath"] as? String else {
                    return
            }
            historicalSites.append(HistoricalSite(name: siteName, location: siteLocation, imagePath: siteImagePath))
        }
        return historicalSites
    }
    
}
