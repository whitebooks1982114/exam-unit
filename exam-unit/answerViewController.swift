//
//  answerViewController.swift
//  exam-unit
//
//  Created by whitebooks on 16/10/23.
//  Copyright © 2016年 whitebooks. All rights reserved.
//

import UIKit

class answerViewController: UIViewController {
    
   
    //计算每一关答过的题目，若果过四关就跳转至结果界面
    var answeredquestion = 0
    //倒计时
    var countDownTime: Timer? = nil
    //题目编号集合
    let questionNum1: NSArray = []
    //当前题目数
    var currentQuestion:Int?
    //倒计时
    var answerTime = 10
    //答对题目数字
    var rightans = 0
    //现在闯的关卡数
    var currentLevel = 0
    
    //题目更新计时器
    var update: Timer? = nil
    
    let path = Bundle.main.path(forResource: "question", ofType: "plist")
    
    
    //按下答题选项按钮后执行
    @IBAction func answerbtn(_ sender: UIButton) {
        
        judgeAnswer(sender: sender)
        
    }
       @IBOutlet weak var img1: UIImageView!
  
 
    @IBOutlet weak var img3: UIImageView!
    
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var timelabel: UILabel!
    
    
    
    //按下取消按钮返回关卡界面
    @IBAction func cancelanswer(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var abtn4: UIButton!
    @IBOutlet weak var abtn3: UIButton!
    //题目标签
   
    @IBOutlet weak var mainquestion: UILabel!
    
    @IBOutlet weak var abtn2: UIButton!
    
    @IBOutlet weak var abtn1: UIButton!
    
   
    //判断答题是否正确
    func judgeAnswer(sender: UIButton){
        //获取所有问题的数组
        let questionArray = NSArray(contentsOfFile:path!)
        //获取第一题数组
        let question = questionArray?[currentQuestion!] as! NSArray
        if sender.tag == question[5] as! Int{
            rightans += 1
       
        }
        self.abtn1.isEnabled = false
        self.abtn2.isEnabled = false
        self.abtn3.isEnabled = false
        self.abtn4.isEnabled = false
        switch question[5] as! Int {
        case 1:
            img1.isHidden = false
        case 2:
            img2.isHidden = false
        case 3:
            img3.isHidden = false
        default:
            img4.isHidden = false
        }
        answeredquestion += 1
        //一秒钟后更新题目
        self.update?.invalidate()
      self.update = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateQuestion), userInfo: nil, repeats: false)
    
    }
    
    //更新题目
    func updateQuestion() {
        //获取所有问题的数组
        let questionArray = NSArray(contentsOfFile:path!)
        currentQuestion! += 1
        let newquestion = questionArray?[currentQuestion!] as! NSArray
        self.mainquestion.text = newquestion[0] as? String
        self.abtn1.setTitle(newquestion[1] as? String, for: .normal)
        self.abtn2.setTitle(newquestion[2] as? String, for: .normal)
        self.abtn3.setTitle(newquestion[3] as? String, for: .normal)
        self.abtn4.setTitle(newquestion[4] as? String, for: .normal)
        self.abtn1.isEnabled = true
        self.abtn2.isEnabled = true
        self.abtn3.isEnabled = true
        self.abtn4.isEnabled = true
        self.img1.isHidden = true
        self.img2.isHidden = true
        self.img3.isHidden = true
        self.img4.isHidden = true
        self.countDownTime?.invalidate()
        //更新时间
        answerTime = 10
        countDownTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timecount), userInfo: nil, repeats: true)
     //每答四道题，跳转结果界面
        if answeredquestion > 3 {
            answeredquestion = 0
            let mystoryBoard = self.storyboard
            let results = mystoryBoard?.instantiateViewController(withIdentifier: "result") as! resultViewController
            results.rightresult = "答对\(self.rightans)"
            results.wrongresult = "答错\(4 - self.rightans)"
            //判断结果界面，答题是否通关，并传值
            if rightans == 4 {
                results.success = "是"
            }else {
                results.success = "否"
            }
            
            if self.rightans == 4 {
                if self.currentLevel < 9 {
                allLevels[currentLevel] = 1
                writeAllLevel()
                } else if self.currentLevel == 9 {
                    print("恭喜通过")
                }
            }
            
            self.navigationController?.pushViewController(results, animated: true)
        }
 
    }
    
    
    //倒计时函数
    func timecount() {
        answerTime -= 1
        if answerTime < 10 {
            timelabel.text = "00:0\(answerTime)"
        }else {
            timelabel.text = "00:\(answerTime)"
        }
        if answerTime <= 0 {
            self.countDownTime?.invalidate()
            let  alart = UIAlertController(title: "警告", message: "时间到", preferredStyle: .alert)
            let  ok = UIAlertAction(title: "好的", style: .default, handler: { (act) in
              let mystoryBoard = self.storyboard
               let results = mystoryBoard?.instantiateViewController(withIdentifier: "result") as! resultViewController
                //let resultsnav = mystoryBoard?.instantiateViewController(withIdentifier: "resultnav") as! UINavigationController
          
                results.rightresult = "答对\(self.rightans)"
                results.wrongresult = "答错\(4 - self.rightans)"
                if self.rightans == 4 {
   
                    if self.currentLevel < 9 {
                      allLevels[self.currentLevel] = 1
                        writeAllLevel()
                    } else if self.currentLevel == 9 {
                        print("恭喜你通过")
                    }
                }
              self.navigationController?.pushViewController(results, animated: true)
                //self.present(resultsnav, animated: true, completion: nil)
             
            })
                alart.addAction(ok)
            self.present(alart, animated: true, completion: nil)
            
        }
    }
    
    func goBack() {
      
       self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "答题界面"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.goBack))

        //隐藏4个视图
        self.img1.isHidden = true
        self.img2.isHidden = true
        self.img3.isHidden = true
        self.img4.isHidden = true
       // self.abtn1.setImage(#imageLiteral(resourceName: "btn2"), for: .normal)
        //self.abtn2.setImage(#imageLiteral(resourceName: "btn2"), for: .normal)
       // self.abtn3.setImage(#imageLiteral(resourceName: "btn2"), for: .normal)
       // self.abtn4.setImage(#imageLiteral(resourceName: "btn2"), for: .normal)
        self.abtn1.contentHorizontalAlignment = .left
        self.abtn2.contentHorizontalAlignment = .left
        self.abtn3.contentHorizontalAlignment = .left
        self.abtn4.contentHorizontalAlignment = .left
        
        
        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                //获取所有问题的数组
        let questionArray = NSArray(contentsOfFile:path!)
        //获取第一题数组
        let question1 = questionArray?[currentQuestion!] as! NSArray
        self.mainquestion.text = question1[0] as? String
        self.abtn1.setTitle(question1[1] as? String, for: .normal)
        self.abtn2.setTitle(question1[2] as? String, for: .normal)
        self.abtn3.setTitle(question1[3] as? String, for: .normal)
        self.abtn4.setTitle(question1[4] as? String, for: .normal)
        //自动换行
        self.mainquestion.lineBreakMode = .byWordWrapping
        
        self.mainquestion.numberOfLines = 0
        //self.abtn1.titleLabel?.adjustsFontSizeToFitWidth = true
        self.abtn1.titleLabel?.numberOfLines = 2
        self.abtn2.titleLabel?.numberOfLines = 2
        //self.abtn2.titleLabel?.adjustsFontSizeToFitWidth = true
        answerTime = 10
        self.countDownTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timecount), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.countDownTime?.invalidate()
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
