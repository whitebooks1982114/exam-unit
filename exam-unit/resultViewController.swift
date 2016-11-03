//
//  resultViewController.swift
//  exam-unit
//
//  Created by whitebooks on 16/10/23.
//  Copyright © 2016年 whitebooks. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet weak var totalnum: UILabel!
  
    @IBOutlet weak var rightnum: UILabel!
    
    @IBOutlet weak var wrongnun: UILabel!
    
    @IBOutlet weak var nextlevel: UILabel!
    
    var rightresult:String = ""
    var wrongresult:String = ""
    var success: String = ""

    func goBack() {
    self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "结果界面"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.goBack))
        self.nextlevel.text = success
        self.rightnum.text = self.rightresult
        self.wrongnun.text = self.wrongresult
              // Do any additional setup after loading the view.
        
           
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.rightnum.text = rightresult
        self.wrongnun.text = wrongresult
        self.nextlevel.text = success
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
