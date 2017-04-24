//
//  MapperViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 24/04/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import UIKit

class MapperViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var svgExampleView: SVGExampleView!

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(showDetail), name: Notification.Name.init(rawValue: "showDetail"), object: nil)
    
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.4
        scrollView.maximumZoomScale = 1.5
        
        scrollView.contentSize.width = 1199
        scrollView.contentSize.height = 800
        
        
        scrollView.addSubview(svgExampleView)
        // Do any additional setup after loading the view.
    }
    
    func showDetail() {
        self.performSegue(withIdentifier: "showFuckinDetail", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return svgExampleView
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
