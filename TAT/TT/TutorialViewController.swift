//
//  TutorialViewController.swift
//  TT
//
//  Created by Enkhtushig Namkhai on 12/7/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var Image1: UIImageView!
    
    @IBOutlet weak var Image2: UIImageView!
    
    @IBOutlet weak var Image3: UIImageView!
    
    @IBOutlet weak var EmojiKingdomImage: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Image1.image = UIImage(named: "weapon00")
        Image2.image = UIImage(named: "weapon12")
        Image3.image = UIImage(named: "weapon21")
        EmojiKingdomImage.image = UIImage(named: "tutorialBackground")

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
