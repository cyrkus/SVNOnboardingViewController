//
//  OnbaordingContentVC.swift
//  Deedz
//
//  Created by Aaron Dean Bikis on 5/1/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

class OnboardingContentViewController: UIViewController {
  
  var image: UIImage
  
  lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.backgroundColor = .clear
    iv.image = self.image
    return iv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imageView)
  }
  
  override func viewDidLayoutSubviews() {
    imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 55)
  }
  
  init(image: UIImage){
    self.image = image
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported")
  }
}
