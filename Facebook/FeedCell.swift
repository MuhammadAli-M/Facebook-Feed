//
//  FeedCell.swift
//  Facebook
//
//  Created by Muhammad Adam on 4/18/20.
//  Copyright © 2020 MAA. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    func configure(posterName: String, posterImage: String, postText: String, postImage: String){
        configureNameLabelText(title: posterName)
        postTextView.text = postText
        textViewDidChange(postTextView)
        userImageView.image = UIImage(named: posterImage)
        statusImageView.image = UIImage(named: postImage)
    }
    
    func configureNameLabelText(title: String, subtitle: String? = nil){
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedString.append(NSAttributedString(string: "\nDecember 18 • San Francisco  • ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSMakeRange(0, attributedString.string.count))
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = #imageLiteral(resourceName: "globe_small")
        textAttachment.bounds = CGRect(x: 0, y: -2, width: 10, height: 10)
        attributedString.append(NSAttributedString(attachment: textAttachment))
        
        nameLabel.attributedText = attributedString

    }
    
    lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    lazy var postTextViewHeightConstraint = postTextView.heightAnchor.constraint(equalToConstant: 0.0)
    lazy var postTextView: UITextView = {
       let txtView = UITextView()
        txtView.isScrollEnabled = false
        txtView.isUserInteractionEnabled = false
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()

    var statusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .purple
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()

    
    lazy var likesAndCommentsLabels: UILabel = {
       let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "131 Likes  390 Comments", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ])
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var likeButton = FeedCell.getButtonForTitle("Like", imageName: "like")
    lazy var commentButton = FeedCell.getButtonForTitle("Comment", imageName: "comment")
    lazy var shareButton = FeedCell.getButtonForTitle("Share", imageName: "share")
    
    func getCenters(totalWidth: Float, numberOfItems:Int, spacing: Float) -> (Float, [Float]){
        let floatNumberOfItems = Float(numberOfItems)
        let widthOfEach = (totalWidth - (floatNumberOfItems - 1) * spacing) / floatNumberOfItems

        let centers: [Float] = (1...numberOfItems).map{ index in
            let first = (Float((2*index - 1)) / 2) * widthOfEach
            let second = Float((index-1)) * spacing
            return first + second
        }

        return (widthOfEach, centers)
    }

    static func getButtonForTitle(_ title: String, imageName: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
//        postTextViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        [userImageView,
         nameLabel,
         postTextView,
         statusImageView,
         likesAndCommentsLabels,
         lineView,
         likeButton,
         commentButton,
         shareButton,
        ].forEach{addSubview($0)}
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            userImageView.widthAnchor.constraint(equalToConstant: 44),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userImageView.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
        ])
        
//        let height = postTextView.sizeThatFits(CGSize(width:frame.size.width, height: .greatestFiniteMagnitude)).height
        NSLayoutConstraint.activate([
            postTextView.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            postTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            postTextView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            postTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
//            postTextViewHeightConstraint
        ])

        
        NSLayoutConstraint.activate([
            statusImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusImageView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 8),
            statusImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            likesAndCommentsLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likesAndCommentsLabels.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 4),
            likesAndCommentsLabels.trailingAnchor.constraint(equalTo: trailingAnchor),
            likesAndCommentsLabels.heightAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lineView.topAnchor.constraint(equalTo: likesAndCommentsLabels.bottomAnchor, constant: 4),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 0.4),
        ])
        
        let spacing = 10.0
        let buttons = [likeButton,commentButton, shareButton]
        // These multipliers and constants are calculated based on that there are 3 buttons.
        let multipliers:[Float] = [1.0/3, 1, 5.0/3]
        let constants:[CGFloat] = [-1.0/3, 0, 1.0/3].map{CGFloat($0*spacing)}
        let widthMultiplier = CGFloat(1.0/3)
        let widthConstant = CGFloat(-2.0/3*spacing)
        
        for (index,button) in buttons.enumerated(){
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: lineView.bottomAnchor),
                button.heightAnchor.constraint(equalToConstant: 30),
                button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiplier, constant: widthConstant)
            ])
            // I used the following way to set the centerX constraint as I could not use button.centerXAnchor.constraint(equalTo: ,multiplier: , constant) as it's not available. The available one does not have multiplier parameter
            NSLayoutConstraint(item: button,
                               attribute: NSLayoutConstraint.Attribute.centerX,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: self, attribute: NSLayoutConstraint.Attribute.centerX,
                               multiplier: CGFloat(multipliers[index]), constant: CGFloat(constants[index])).isActive = true
            
        }
        
        // It's possible to use UIStackView and get out of this hassle but I just want to  try it out.

    }
    
}



extension FeedCell: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {

//        let height = postTextView.sizeThatFits(CGSize(width:frame.size.width, height: .greatestFiniteMagnitude)).height
//        postTextViewHeightConstraint.constant = height

    }
}
