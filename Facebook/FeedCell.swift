//
//  FeedCell.swift
//  Facebook
//
//  Created by Muhammad Adam on 4/18/20.
//  Copyright © 2020 MAA. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    public static let cellId = "cellId"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        self.selectionStyle = .none
        setupViews()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var post: Post?{
        didSet{
            configureNameLabelText(title: post?.userName ?? "")
             postTextView.text = post?.postText
             userImageView.image = UIImage(named: post?.userImage ?? "")
            if let image = UIImage(named: post?.postImageName ?? ""){
                statusImageView.image = image
                statusImageViewHeightConstraint.constant = 200
            }else{
                statusImageViewHeightConstraint.constant = 0
            }
        }
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
    
    private lazy var statusImageViewHeightConstraint = NSLayoutConstraint(item: statusImageView,
                                                                     attribute: .height,
                                                                     relatedBy: .equal,
                                                                     toItem: nil,
                                                                     attribute: .notAnAttribute,
                                                                     multiplier: 1,
                                                                     constant: 200)
    
    private lazy var postTextView: UITextView = {
       let txtView = UITextView()
        txtView.isScrollEnabled = false
        txtView.isUserInteractionEnabled = false
        txtView.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()

    private var statusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .purple
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()

    
    private lazy var likesAndCommentsLabels: UILabel = {
       let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "131 Likes  390 Comments", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ])
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton = FeedCell.getButtonForTitle("Like", imageName: "like")
    private lazy var commentButton = FeedCell.getButtonForTitle("Comment", imageName: "comment")
    private lazy var shareButton = FeedCell.getButtonForTitle("Share", imageName: "share")

    private func getCenters(totalWidth: Float, numberOfItems:Int, spacing: Float) -> (Float, [Float]){
        let floatNumberOfItems = Float(numberOfItems)
        let widthOfEach = (totalWidth - (floatNumberOfItems - 1) * spacing) / floatNumberOfItems

        let centers: [Float] = (1...numberOfItems).map{ index in
            let first = (Float((2*index - 1)) / 2) * widthOfEach
            let second = Float((index-1)) * spacing
            return first + second
        }

        return (widthOfEach, centers)
    }

    static private func getButtonForTitle(_ title: String, imageName: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func setupViews(){
        
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
        
        NSLayoutConstraint.activate([
            postTextView.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            postTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            postTextView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            postTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])

        
        NSLayoutConstraint.activate([
            statusImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusImageView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 8),
            statusImageViewHeightConstraint
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
        
        // It's possible to use UIStackView and get rid of this hassle but I just want to try it out.
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -4),
        ])

    }
    
}
