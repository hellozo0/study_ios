//
//  ViewController.swift
//  Navbar
//
//  Created by 안현주 on 2021/09/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Click_moveBtn(_ sender: Any) {
        //버튼을 눌러서 오른쪽으로 이동 시킬 거임
        
        //1. 스토리보드에서 controller를 찾는다 (찾음을 당할 컴트롤러에 identity를 부여)  : DetailController
        //변수 생성, nil(null) 값이 있을 수도 있고 없을 수도 있고....
        //값이 있을 때 진행 ,옵셔널 바인딩
        if let controller = self.storyboard?.instantiateViewController(identifier: "DetailController"){
            //push, add? move controller = navi
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        
        
        //2. 이동할 컨트롤러로 이동한다.
    }
    
    
    
    
    
    
    

}

