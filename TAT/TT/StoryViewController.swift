//
//  StoryViewController.swift
//  TT
//
//  Created by Enkhtushig Namkhai on 12/6/16.
//  Copyright © 2016 Ziwei Yin. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    var StoryContent = ["He was loved by all...", "One day the evil dog kingdom wanted to join the emoji kingdom...", "To which the king said NO!", "Enraged because of the refusal, the Dog kingdom waged a war against the emoji kingdom... PROTECT THE KING AND SAVE EMOJI KINGDOM!"]
    var count = 0
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Content: UILabel!
    
    @IBOutlet weak var NextButton: UIButton!
 
    

    
    @IBAction func CloseClicked(_ sender: Any) {
        print("before set to 0 " + String(count) + "\n")
        count = 0
        print("after set to 0 " + String(count) + "\n")
        //switch to the main screen
    }
    
    
    
    @IBAction func NextClicked(_ sender: Any) {
        if count >= (3) {
            print(count)
            //should hide the next
            NextButton.isHidden = true
            NextButton.isEnabled = false
            //or go to the main screen
        }
        print("next Clicked\n")
        print(String(count) + "\n")
        Content.text = StoryContent[count]
        Image.image = UIImage(named: "story" + String(count) + ".png")
        count += 1
        
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Content.text = "There was once a king that ruled the emoji kingdom..."
        Image.image = UIImage(named: "story.png")
        

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
