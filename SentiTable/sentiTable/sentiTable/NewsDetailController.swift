//
//  NewsDetailController.swift
//  sentiTable
//
//  Created by 안현주 on 2021/09/18.
//

import UIKit

class NewsDetailController : UIViewController {
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    
    
    //1. image url
    //2. description
    
    var imageUrl : String?
    var desc : String?
    
    
    
    //UIViewController에게 전달
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //값이 있으면?
        if let img = imageUrl{
            //이미지를 가져와서 뿌린다.
            //Data방법 사용 :
            //여태 막 URLsession.shared...이런식으로 했는데
            if let data = try? Data(contentsOf: URL(string: img)!) {
                //UI가 바뀌는 동작은 Main Thread
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
        }
        if let d = desc{
            //뉴스 본문을 보여준다
            self.LabelMain.text = d
        }
        
    }
}
