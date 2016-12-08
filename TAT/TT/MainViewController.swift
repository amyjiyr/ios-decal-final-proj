//
//  MainViewController.swift
//  TT
//
//  Created by Enkhtushig Namkhai on 12/6/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBAction func StoryClicked(_ sender: Any) {
    }

    @IBOutlet weak var StartGame: UIButton!
    
    @IBOutlet weak var Tutorial: UIButton!
    
    @IBOutlet weak var Story: UIButton!
    
    @IBOutlet weak var Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartGame.backgroundColor = UIColor.clear
        StartGame.layer.cornerRadius = 5
        StartGame.layer.borderWidth = 1
        StartGame.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5).cgColor
        
        Tutorial.backgroundColor = UIColor.clear
        Tutorial.layer.cornerRadius = 5
        Tutorial.layer.borderWidth = 1
        Tutorial.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5).cgColor
        
        Story.backgroundColor = UIColor.clear
        Story.layer.cornerRadius = 5
        Story.layer.borderWidth = 1
        Story.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5).cgColor
        
        Image.image = UIImage(named: "MainBackgroundComplete" )
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
