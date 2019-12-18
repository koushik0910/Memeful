//
//  PostWithCommentsViewController.swift
//  Memeful
//
//  Created by Koushik Dutta on 17/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class PostWithCommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PostDetailsViewModel()
    var postData : MostViralPostViewModel?
    fileprivate var selectedItem : Datum?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var selectedItemIndex : Int = 0{
        didSet{
            if let id = postData?.postData[selectedItemIndex].id{
                viewModel.fetchComments(for: id) {
                    [unowned self] in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        selectedItem = postData?.postData[selectedItemIndex]
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if selectedItemIndex > 0{
                    selectedItemIndex -= 1
                }
            case UISwipeGestureRecognizer.Direction.left:
                if selectedItemIndex < (postData?.postData.count ?? 0) - 1 {
                    selectedItemIndex += 1
                }
            default:
                break
            }
            selectedItem = postData?.postData[selectedItemIndex]
        }
    }
}

extension PostWithCommentsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commentsData.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageTableViewCell
            cell.postDetails = selectedItem
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BestCommentsStaticCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BestCommentsCell", for: indexPath) as! BestCommentsTableViewCell
            cell.commentDetails = viewModel.commentsData[indexPath.row - 2]
            return cell
        }
    }
    
}
