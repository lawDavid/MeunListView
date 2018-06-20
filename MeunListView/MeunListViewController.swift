//
//  MeunListViewController.swift
//  testNavigation
//
//  Created by DavidLaw on 2018/4/11.
//  Copyright © 2018年 DavidLaw. All rights reserved.
//

import UIKit

class MeunListViewController: UIViewController {

    @IBOutlet weak var meunView: MeunListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectModel1 = MeunListModel()
        selectModel1.title = "蒙城大区01"
        let selectModel2 = MeunListModel()
        selectModel2.title = "蒙城大区02"
        let selectModel3 = MeunListModel()
        selectModel3.title = "蒙城大区03"
        let selectModel4 = MeunListModel()
        selectModel4.title = "蒙城大区04"
        let selectModel5 = MeunListModel()
        selectModel5.title = "蒙城大区05"
        let list1 = [selectModel1, selectModel2, selectModel3, selectModel4, selectModel5]
        
        
        let selectModel6 = MeunListModel()
        selectModel6.title = "全部类型"
        let selectModel7 = MeunListModel()
        selectModel7.title = "第二种类型"
        let selectModel8 = MeunListModel()
        selectModel8.title = "第三种类型"
        let list2 = [selectModel6, selectModel7, selectModel8]

        let selectedIndexs = [0 , 1]

        meunView.selectedCellIndexs = selectedIndexs
        meunView.meunModels = [list1, list2]
        meunView.selectCompleteHandler = { indexs in
            print(indexs)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
