//
//  ViewController.swift
//  SampleWebView
//
//  Created by 안현주 on 2021/09/13.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var WebViewMain: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //web view 사용법
        //1. url String을 찾는다
        //2. url string을 URL(을 거쳐) URL Request로 만들기
        //3. URLRequest를 웹뷰에 뿌린다.
        
        
        let urlString = "https://www.google.com"
        if let url = URL(string: urlString){ //(unwrap과정 : 비어있을수도 있는데, 값이 있는 경우 if문 실행
            let urlReq = URLRequest(url: url)
            WebViewMain.load(urlReq)
        }
        
        //<var의 2가지 형태>

//        (1) var abc = "1"

//        (2) var abc1 :String?  → 값이 비어있을 수 있다(nill일 수 있다),  이러면 unwrap 과정을 진행해야한다. (if문을 통해 하거나, 강제로 버끼거나 ?을 !로 사용해서 강제로)

//        - let aaa = abc! → 만약 nill인데 !을 사용하면 에러가 날 수 있다. 따라서 if문으로 해결(if문으로 해결하는 것 : 옵셔널 바인딩이라고 한다)
//        - if let unwrap = abc1{  }

//        let abc2 = "2"

        //null Pointer Exception : 값이 비어있는데 강제로 사사용할려고 하는 것 - java
        
    }

}

