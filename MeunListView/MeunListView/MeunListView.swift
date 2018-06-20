//
//  MeunListView.swift
//  testNavigation
//
//  Created by DavidLaw on 2018/4/11.
//  Copyright © 2018年 DavidLaw. All rights reserved.
//

import UIKit

class MeunListView: UIView {
    
    @IBOutlet private var meunCollectionView: UICollectionView!
    @IBOutlet private var listTableView: UITableView!
    
    // the index which has been selected
    var selectedCellIndexs: [Int]?
    
    // the listModels collection
    var meunModels = [[MeunListModel]]() {
        didSet {
            if selectedCellIndexs == nil {
                selectedCellIndexs = [Int]()
                for _ in meunModels {
                    selectedCellIndexs!.append(0)
                }
            }
        }
    }
    
    // call back block
    var selectCompleteHandler: (([Int]) -> Void)?
    
    // bottom padding use when vc has bottomBar which don't wantna be covering by the showing list
    var listBottomPadding = 0.0
    
    // the colletionView selected item, if nil hide tableView
    private var selectedItem: Int? {
        didSet {
            if let temp = selectedItem {
                currListModels = meunModels[temp]
            }
        }
    }
    
    // the listModels which selected from meun item
    private var currListModels = [MeunListModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(meunCollectionView)
        meunCollectionView.frame = self.bounds
        meunCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        meunCollectionView.register(UINib(nibName: "MeunListItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MeunListItemCell")
        listTableView.register(UINib(nibName: "MeunListCell", bundle: Bundle.main), forCellReuseIdentifier: "MeunListCell")
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        listTableView.backgroundView = backgroundView;
    }
    
    func showListTableView(_ isShow: Bool) {
        let original = self.frame.origin
        let backgroundHeight = superview!.bounds.height - self.frame.height - original.y
        let listHeight = backgroundHeight - CGFloat(listBottomPadding)
        if isShow {
            listTableView.frame = CGRect(x: original.x, y: original.y + self.frame.height, width: self.frame.width, height: 0)
            superview!.addSubview(listTableView)
            // showing the list with animiation
            UIView.animate(withDuration: 0.2, animations: {
                self.listTableView.frame = CGRect(x: original.x, y: original.y + self.frame.height, width: self.frame.width, height: listHeight)
            })
        }
        else {
            // hidden the list with animation
            UIView.animate(withDuration: 0.2, animations: {
                self.listTableView.frame = CGRect(x: original.x, y: original.y + self.frame.height, width: self.frame.width, height: 0)
            }, completion: { succeed in
                self.listTableView.removeFromSuperview()
            })
        }
    }
    
    func reloadListWithAnimation() {
        listTableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
    @objc func tapAction() {
        selectedItem = nil
        showListTableView(false)
        meunCollectionView.reloadData()
    }
}

extension MeunListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currListModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MeunListCell = tableView.dequeueReusableCell(withIdentifier: "MeunListCell", for: indexPath) as! MeunListCell
        let model = currListModels[indexPath.row]
        cell.model = model
        if indexPath.row == selectedCellIndexs![selectedItem!] {
            cell.isSelected = true
        }
        else {
            cell.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndexs![selectedItem!] = indexPath.row
        meunCollectionView.reloadData()
        listTableView.reloadData()
    }
}

extension MeunListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.bounds.size.width / CGFloat(meunModels.count)
        let height = self.bounds.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meunModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MeunListItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeunListItemCell", for: indexPath) as! MeunListItemCell
        let models = meunModels[indexPath.row]
        let selectedIndex = selectedCellIndexs![indexPath.row]
        cell.model = models[selectedIndex]
        if indexPath.row == selectedItem {
            cell.isSelected = true
        }
        else {
            cell.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedItem != indexPath.row {
            if selectedItem == nil {
                selectedItem = indexPath.row
                showListTableView(true)
                listTableView.reloadData()
            }
            else {
                selectedItem = indexPath.row
                reloadListWithAnimation()
            }
        }
        else {
            selectedItem = nil
            showListTableView(false)
            selectCompleteHandler?(selectedCellIndexs!)
        }
        meunCollectionView.reloadData()
    }
}
