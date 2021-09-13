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
        //1번 방법 - 임의의 셀을 만들기
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
        
        
        
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

