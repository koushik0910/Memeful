//
//  MostViralPostsViewController.swift
//  Memeful
//
//  Created by Koushik Dutta on 14/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class MostViralPostsViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedItem = 0
    var pageIndex = 0
    var isLoading = false
    var viewModel = MostViralPostViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView?.collectionViewLayout as? MemeCellLayout {
            layout.delegate = self
        }
        self.viewModel.fetchData(for : pageIndex, onCompletion: {
            [unowned self] in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

extension MostViralPostsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostViralPostsCell", for: indexPath as IndexPath) as! MostViralPostsCollectionViewCell
        cell.postDetails = self.viewModel.postData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= (self.viewModel.postData.count - 3){
            if !isLoading{
                isLoading = true
                pageIndex += 1
                self.viewModel.fetchData(for : pageIndex, onCompletion: {
                    [unowned self] in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.collectionView.reloadData()
                    }
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        performSegue(withIdentifier: "GotoPostWithComments", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoPostWithComments"{
            if let vc = segue.destination as? PostWithCommentsViewController
            {
                vc.postData = viewModel
                vc.selectedItemIndex = selectedItem
            }
        }
    }
    
}

extension MostViralPostsViewController : MemeCellLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath: IndexPath) -> CGFloat {
        var imageHeight = CGFloat()
        if let imageLink = viewModel.postData[heightForItemAtIndexPath.row].images?.first?.link{
            if imageLink.contains("gif") || imageLink.contains("png") || imageLink.contains("jpg") || imageLink.contains("jpeg"){
                imageHeight = (UIScreen.main.bounds.width/2 - 10) * CGFloat(self.viewModel.postData[heightForItemAtIndexPath.row].images?.first?.aspectRatio ?? 1)
            }else{
                imageHeight = 133
            }
        }else{
            imageHeight = 133
        }
        
        let height = imageHeight + getLabelSize(text: viewModel.postData[heightForItemAtIndexPath.row].title ?? "") + 32
        return height
    }
    
    func getLabelSize(text : String) -> CGFloat {
        let newLabel = UILabel()
        newLabel.text = text
        let size = newLabel.sizeThatFits(CGSize())
        let height = ceil(size.width / (UIScreen.main.bounds.width/2 - 10 - 16))
        let actualHeight = min(max(1, height), 5)
        print("text : \(text), height : \(actualHeight)")
        return actualHeight * 26
    }
}
