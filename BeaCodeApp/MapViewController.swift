//
//  MapViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    var mapImageView : UIImageView = UIImageView()
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        mapImageView.frame.size.width = 2000
        mapImageView.frame.size.height = 800
        mapImageView.image = UIImage(named: "defaultmap.png")
        scrollView.maximumZoomScale = 1.2
        scrollView.minimumZoomScale = 0.6
        
        scrollView.contentSize.width = 2000
        scrollView.contentSize.height = 800
        
        mapImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        scrollView.addSubview(mapImageView)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
