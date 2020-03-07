//
//  DiaryTableViewCell.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/2/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

protocol DiaryTableViewCellDelegate {
    func didTapEditButton(diaryPage: DiaryPage)
}

class DiaryTableViewCell: UITableViewCell {
    
    var diaryTableViewCellDelegate: DiaryTableViewCellDelegate?
    var hasPhotos: Bool = false
    /*
     함수명: diarypage
     기능: 들어오는 diarypage 마다 Observe 해 cell 을 로드한다.
     작성일자: 2019.07.15
     수정일자: 2020.02.18
     */
    var diarypageViewModel: DiaryPageViewModel? {
        didSet {
//            guard let date = self.diarypage?.getDate() else {return}
//            guard let title = self.diarypage?.getTitle() else {return}
//            guard let text = self.diarypage?.getText() else {return}

            guard let date = self.diarypageViewModel?.date else {return}
            guard let title = self.diarypageViewModel?.title else {return}
            guard let text = self.diarypageViewModel?.text else {return}
            var diaryImages = [UIImage]()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            titleLable.text = title
            dateLabel.text = dateString
            diaryTextView.text = text
            
            if hasPhotos {
                self.setviews()
            } else {
                self.setviewsWithoutNoImageView()
            }

//            if let diarypageViewModel = self.diarypageViewModel, diarypageViewModel.images.count != 0 {
//                subviews()
//                diaryImageView.image = diarypageViewModel.images[0]
////                setupSlideImageOnScrollView(slides: diarypageViewModel.images)
//            } else {
//                setviewsWithoutNoImageView()
//            }

            //diary 에 이미지가 있다면, 이미지를 가져와 붙인다.
//            if self.diarypage?.images != nil && self.diarypage?.images?.count != 0 {
//                guard let images = self.diarypage?.images else {return}
//                images.forEach { (image) in
//                    guard let imageFile = ConvertingDataAndImage().convertingFromUrlToImage(uniqueId: image.getUrl()) else {return}
//                    diaryImages.append(imageFile)
//                }
//                setviews()
//                setupSlideImageOnScrollView(slides: diaryImages)
//            } else {
//                setviewsWithoutNoImageView()
//            }

        }

    }
 
    
    //MARK: - CellHeadViewPart
    let diaryHeadView: UIView = {
       let diaryHeadView = UIView()
        return diaryHeadView
    }()
    
    let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "ProfileIcon")
        profileImageView.layer.cornerRadius = 35/2
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()
    
    let titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Diary Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "date"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        dateLabel.textColor = .darkGray
        return dateLabel
    }()
    
    lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.setImage(UIImage(named: "SetButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return editButton
    }()
    
    @objc func handleEditButton() {
//        self.diaryTableViewCellDelegate?.didTapEditButton(diaryPage: self.diarypage!)
    }
    
    //MARK: - diaryImageView
    let diaryImageView: UIImageView = {
        let diaryImageView = UIImageView()
        return diaryImageView
    }()
    
    let diaryImageViews: [UIImageView] = {
        let diaryImageView = [UIImageView]()
        return diaryImageView
    }()
    
    let pagenationScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let pageController: UIPageControl = {
        let pageNation = UIPageControl()
        return pageNation
    }()
    
    private func setupSlideImageOnScrollView(slides: [UIImage]) {
        pagenationScrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 350)
        pagenationScrollView.contentSize = CGSize(width: self.frame.width * CGFloat(slides.count), height: 350)
        pagenationScrollView.isPagingEnabled = true
        
        for i in 0...slides.count - 1 {
            let imageView = UIImageView()
            imageView.backgroundColor = .white
            imageView.image = slides[i]
            
            imageView.frame = CGRect(x: self.pagenationScrollView.frame.width * CGFloat(i), y: 0, width: self.pagenationScrollView.frame.width, height: 350)
            pagenationScrollView.addSubview(imageView)
        }
    }
    
    //MARK: - diaryTextView
    let diaryTextView: UITextView = {
        let diaryTextView = UITextView()
        diaryTextView.allowsEditingTextAttributes = false
        diaryTextView.isEditable = false
        diaryTextView.font = UIFont.systemFont(ofSize: 18)
        diaryTextView.text = "test"
        return diaryTextView
    }()
    
    //MARK: - stackButtonSeperateView
    let stackButtonSeperatView: UIView = {
        let stackButtonSeperatView = UIView()
        stackButtonSeperatView.backgroundColor = .lightGray
        return stackButtonSeperatView
    }()
    
    //MARK: - diaryOptionButtonStackView
    let commentButton: UIButton = {
        let commentButton = UIButton()
        commentButton.setImage(UIImage(named: "CommentIcon"), for: .normal)
        commentButton.setAttributedTitle(NSAttributedString(string: " Comment"), for: .normal)
        return commentButton
    }()
    
    let favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(named: "FavoriteIcon"), for: .normal)
        favoriteButton.setAttributedTitle(NSAttributedString(string: " Favorite"), for: .normal)
        return favoriteButton
    }()

    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "ShareIcon"), for: .normal)
        shareButton.setAttributedTitle(NSAttributedString(string: " Share"), for: .normal)
        return shareButton
    }()
    
    //MARK: - diaryTableCellSeperatorView
    let diaryTableCellSeparatorView: UIView = {
       let diaryTableCellSeparatorView = UIView()
        diaryTableCellSeparatorView.backgroundColor = .lightGray
        return diaryTableCellSeparatorView
    }()
    
//    public func configureWithImageView(viewModel: DiaryPageViewModel) {
////        self.pagenationScrollView.isHidden = false
//        diaryImageView.isHidden = false
//        addSubview(diaryHeadView)
//        diaryHeadView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:48)
//
//        diaryHeadView.addSubview(profileImageView)
//        diaryHeadView.addSubview(titleLable)
//        diaryHeadView.addSubview(dateLabel)
//        diaryHeadView.addSubview(editButton)
//
//        profileImageView.anchor(top: nil, left: diaryHeadView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
//        profileImageView.centerYAnchor.constraint(equalToSystemSpacingBelow: diaryHeadView.centerYAnchor, multiplier: 0).isActive = true
//        titleLable.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        dateLabel.anchor(top: titleLable.bottomAnchor, left: titleLable.leftAnchor, bottom: nil, right: nil, paddingTop: 2.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        editButton.anchor(top: diaryHeadView.topAnchor, left: nil, bottom: diaryHeadView.bottomAnchor, right: diaryHeadView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
//
//        //        addSubview(pagenationScrollView)
//        addSubview(diaryImageView)
//        addSubview(diaryTextView)
//        addSubview(stackButtonSeperatView)
//
//        //        pagenationScrollView.anchor(top: diaryHeadView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
//        diaryImageView.anchor(top: diaryHeadView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
//        diaryTextView.anchor(top: diaryImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingBottom: 0, paddingRight: 50, width: 0, height: 150)
//        stackButtonSeperatView.anchor(top: diaryTextView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
//
//        let diaryOptionStackView = UIStackView(arrangedSubviews: [commentButton,favoriteButton,shareButton])
//        diaryOptionStackView.axis = .horizontal
//        diaryOptionStackView.distribution = .fillEqually
//
//        addSubview(diaryOptionStackView)
//        addSubview(diaryTableCellSeparatorView)
//        diaryOptionStackView.anchor(top: stackButtonSeperatView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
//        diaryTableCellSeparatorView.anchor(top: diaryOptionStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter.string(from: viewModel.date)
//
//        titleLable.text = viewModel.title
//        dateLabel.text = dateString
//        diaryTextView.text = viewModel.text
//        diaryImageView.image = viewModel.images[0]
//
//    }
    
    private func setviews() {
        self.pagenationScrollView.isHidden = false
        addSubview(diaryHeadView)
        diaryHeadView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:48)

            diaryHeadView.addSubview(profileImageView)
            diaryHeadView.addSubview(titleLable)
            diaryHeadView.addSubview(dateLabel)
            diaryHeadView.addSubview(editButton)

        profileImageView.anchor(top: nil, left: diaryHeadView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        profileImageView.centerYAnchor.constraint(equalToSystemSpacingBelow: diaryHeadView.centerYAnchor, multiplier: 0).isActive = true
        titleLable.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dateLabel.anchor(top: titleLable.bottomAnchor, left: titleLable.leftAnchor, bottom: nil, right: nil, paddingTop: 2.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        editButton.anchor(top: diaryHeadView.topAnchor, left: nil, bottom: diaryHeadView.bottomAnchor, right: diaryHeadView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)

//        addSubview(pagenationScrollView)
        addSubview(diaryImageView)
        addSubview(diaryTextView)
        addSubview(stackButtonSeperatView)

//        pagenationScrollView.anchor(top: diaryHeadView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        diaryImageView.anchor(top: diaryHeadView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        diaryTextView.anchor(top: diaryImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingBottom: 0, paddingRight: 50, width: 0, height: 150)
        stackButtonSeperatView.anchor(top: diaryTextView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)

        let diaryOptionStackView = UIStackView(arrangedSubviews: [commentButton,favoriteButton,shareButton])
        diaryOptionStackView.axis = .horizontal
        diaryOptionStackView.distribution = .fillEqually

        addSubview(diaryOptionStackView)
        addSubview(diaryTableCellSeparatorView)
        diaryOptionStackView.anchor(top: stackButtonSeperatView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        diaryTableCellSeparatorView.anchor(top: diaryOptionStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)

    }
    
//    public func configureView(viewModel: DiaryPageViewModel) {
////        self.pagenationScrollView.isHidden = false
//        self.diaryImageView.isHidden = true
//        addSubview(diaryHeadView)
//        diaryHeadView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:48)
//
//        diaryHeadView.addSubview(profileImageView)
//        diaryHeadView.addSubview(titleLable)
//        diaryHeadView.addSubview(dateLabel)
//        diaryHeadView.addSubview(editButton)
//
//        profileImageView.anchor(top: nil, left: diaryHeadView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
//        profileImageView.centerYAnchor.constraint(equalToSystemSpacingBelow: diaryHeadView.centerYAnchor, multiplier: 0).isActive = true
//        titleLable.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        dateLabel.anchor(top: titleLable.bottomAnchor, left: titleLable.leftAnchor, bottom: nil, right: nil, paddingTop: 2.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        editButton.anchor(top: diaryHeadView.topAnchor, left: nil, bottom: diaryHeadView.bottomAnchor, right: diaryHeadView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
//
//        addSubview(diaryTextView)
//        addSubview(stackButtonSeperatView)
//
//        diaryTextView.anchor(top: diaryHeadView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingBottom: 0, paddingRight: 50, width: 0, height: 150)
//        stackButtonSeperatView.anchor(top: diaryTextView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
//
//        let diaryOptionStackView = UIStackView(arrangedSubviews: [commentButton,favoriteButton,shareButton])
//        diaryOptionStackView.axis = .horizontal
//        diaryOptionStackView.distribution = .fillEqually
//
//        addSubview(diaryOptionStackView)
//        addSubview(diaryTableCellSeparatorView)
//        diaryOptionStackView.anchor(top: stackButtonSeperatView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
//        diaryTableCellSeparatorView.anchor(top: diaryOptionStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter.string(from: viewModel.date)
//
//        titleLable.text = viewModel.title
//        dateLabel.text = dateString
//        diaryTextView.text = viewModel.text
//
//    }
    
    private func setviewsWithoutNoImageView() {
        self.pagenationScrollView.isHidden = false
        addSubview(diaryHeadView)
        diaryHeadView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:48)
        
        diaryHeadView.addSubview(profileImageView)
        diaryHeadView.addSubview(titleLable)
        diaryHeadView.addSubview(dateLabel)
        diaryHeadView.addSubview(editButton)
        
        profileImageView.anchor(top: nil, left: diaryHeadView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        profileImageView.centerYAnchor.constraint(equalToSystemSpacingBelow: diaryHeadView.centerYAnchor, multiplier: 0).isActive = true
        titleLable.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dateLabel.anchor(top: titleLable.bottomAnchor, left: titleLable.leftAnchor, bottom: nil, right: nil, paddingTop: 2.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        editButton.anchor(top: diaryHeadView.topAnchor, left: nil, bottom: diaryHeadView.bottomAnchor, right: diaryHeadView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
    
        addSubview(diaryTextView)
        addSubview(stackButtonSeperatView)
        
        diaryTextView.anchor(top: diaryHeadView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingBottom: 0, paddingRight: 50, width: 0, height: 150)
        stackButtonSeperatView.anchor(top: diaryTextView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        let diaryOptionStackView = UIStackView(arrangedSubviews: [commentButton,favoriteButton,shareButton])
        diaryOptionStackView.axis = .horizontal
        diaryOptionStackView.distribution = .fillEqually
        
        addSubview(diaryOptionStackView)
        addSubview(diaryTableCellSeparatorView)
        diaryOptionStackView.anchor(top: stackButtonSeperatView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        diaryTableCellSeparatorView.anchor(top: diaryOptionStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.hasPhotos {
            self.setviews()
        } else {
            self.setviewsWithoutNoImageView()
        }
        
//        self.diarypageViewModel = DiaryPageViewModel()
//        var diaryImages = [UIImage]()
        
//        if self.diarypage?.images != nil && self.diarypage?.images?.count != 0 {
//            setupSlideImageOnScrollView(slides: diaryImages)
//        }
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
