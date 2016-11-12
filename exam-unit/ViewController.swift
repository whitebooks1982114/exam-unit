//
//  ViewController.swift
//  exam-unit
//
//  Created by whitebooks on 16/10/23.
//  Copyright © 2016年 whitebooks. All rights reserved.
//

import UIKit

//记录所有关卡状态
var allLevels = [1,0,0,0,0,0,0,0,0]
func writeAllLevel() {
    let ud = UserDefaults.standard
    for i in 0...8 {
        ud.set(allLevels[i], forKey: "Level\(i + 1)")
        
    }
}

func readAllLevel() {
    let ud = UserDefaults.standard
    for i in 0...8 {
        allLevels[i] = ud.integer(forKey: "Level\(i + 1)")
        
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    
    //如果关卡开锁转入答题界面，否则弹出警告框
    @IBAction func turnanswer(_ sender: UIButton) {
        let btn  = sender as UIButton
        let tag  = btn.tag
        if allLevels[tag-1] == 1 {
            let mystoryBoard = self.storyboard
            let answer = mystoryBoard?.instantiateViewController(withIdentifier: "answer") as! answerViewController
            answer.currentLevel = tag
            answer.currentQuestion = 4*(tag - 1)
          self.navigationController?.pushViewController(answer, animated: true)
        }else {
            let alart = UIAlertController(title: "警告", message: "请您先闯过上一关", preferredStyle: .alert)
            let okaction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
            alart.addAction(okaction)
            self.present(alart, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        allLevels[0] = 1
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          readAllLevel()
        //记录关卡按钮状态
        let btns: [UIButton] = [btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9]
       //遍历按钮，调整是否有锁图案
        for item in btns {
            if allLevels[item.tag-1] == 1 {
                item.setImage(nil, for: .normal)
            }else {
                item.setImage(#imageLiteral(resourceName: "lock"), for: .normal)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

