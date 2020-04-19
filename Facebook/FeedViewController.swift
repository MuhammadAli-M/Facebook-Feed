//
//  ViewController.swift
//  Facebook
//
//  Created by Muhammad Adam on 4/15/20.
//  Copyright © 2020 MAA. All rights reserved.
//

import UIKit

struct Post{
    var posterName: String
    var posterImageName: String
    var postText: String
    var imageName: String
}


let cellId = "cellId"
class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let posts = [
        Post(posterName: "Mark Zukerberg", posterImageName: "mark zuckerberg", postText: "By giving people the power to share, we're making the world more transparent.", imageName: "zukerberg dog"),
        Post(posterName: "Steve Jobs", posterImageName: "mark zuckerberg", postText: "This is Steve's text. I think the profile image is misleading but it's okay. I think this should be longer than that. Let's see.", imageName: "zukerberg dog"),
        Post(posterName: "Harry Potter", posterImageName: "mark zuckerberg", postText: "This is Harry's text. These days are really tough. Enough! . let's enjoy. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", imageName: "zukerberg dog"),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .gray
        collectionView.alwaysBounceVertical = true
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x58729C)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Feed"
        
        if let customFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
        customFlowLayout.sectionInsetReference = .fromContentInset // .fromContentInset is default
              customFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
              customFlowLayout.minimumInteritemSpacing = 10
              customFlowLayout.minimumLineSpacing = 10
              customFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//              customFlowLayout.headerReferenceSize = CGSize(width: 0, height: 40)

              collectionView.collectionViewLayout = customFlowLayout
              collectionView.contentInsetAdjustmentBehavior = .always
        }
//        layout?.estimatedItemSize = CGSize(width: collectionView.frame.width, height: 300) // your average cell size
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt is called for id \(indexPath.row)")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        cell.configure(posterName: posts[indexPath.row].posterName,
                       posterImage: posts[indexPath.row].posterImageName,
                       postText: posts[indexPath.row].postText,
                       postImage: posts[indexPath.row].imageName)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
//        self.view.layoutSubviews()
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        print("sizeForItemAt is called for id \(indexPath.row)")
////        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
////        let textViewSizeHeight = cell.postTextView.sizeThatFits(CGSize(width:collectionView.frame.size.width, height: .greatestFiniteMagnitude)).height
//        let textViewSizeHeight = 50
//        return CGSize(width: collectionView.frame.size.width, height: 350+CGFloat(textViewSizeHeight))
//    }

    
//    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        
////        collectionView.preferredMaxLayoutWidth = layoutAttributes.frame.width
//        layoutAttributes.frame.size.height = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//        return layoutAttributes
//    }

 
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}






