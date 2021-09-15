//
//  ViewController.swift
//  sentiTable
//
//  Created by 안현주 on 2021/09/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //2. 데이터 몇개인지.
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. 데이터 무엇인지. --> 10번 반복..? --> 10개의 cell...?!
        
        //2가지 방법으로 cell 사용하는 법
        //1번 방법 - 임의의 셀을 만들기 : 거의 안씀, 연습
        //2번 방법 - 스토리보드 + id : 실전
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Type1")
        
        //정의한다. 다시 재사용할 수 있는 셀을 정의해서 테이블뷰 메인에 꽃아넣는다. 순번에 해당하는 것을 만나면 Type1에 있는 것을 넣는다.
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        //as? as! - 부모 자식 친자확인
        //타입을 안전하게 추론하는 as?와 강제로 변환하는 as!
        cell.LabelText.text = "\(indexPath.row)"
        
//        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
        
        
        
    }
    

    
    //클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK !!! \(indexPath.row)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
    }

    
    //tableview는 테이블로 된 뷰 - 여러개의 행이 모여있는 목록 뷰(화면)
    //왜 쓰는가 ? 정갈하게 보여줄려고! ex)전화번호부
    
    //1. 데이터가 무엇인지 - 전화번호 목록
    //2. 데이터가 몇개인지 - 100,1000,10000개
    //3. (옵션) 데이터 행을 눌렀다. - 클릭했다.

}

