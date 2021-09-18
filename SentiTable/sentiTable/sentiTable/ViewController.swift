//
//  ViewController.swift
//  sentiTable
//
//  Created by 안현주 on 2021/09/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    
    //ch10 내용
    //1. http 통신 방법 - urlsession 방식
    // 바이트형태로 주고받는 방식이나 http방식
 
    //2. JSON 데이터 형태 {"돈":"10000"} 배열 형태의 {["10000",{"돈":"10000"} ,"100"]}
    //JSON은 서버-클라이언크가 정보를 주고받을때 규약이 없었었음
    
    //3. taleview의 데이터 매칭!! <- 통보 후 그리기!
    //!!!!!! (중요) swift는 네트워크 통신을 할때, 일꾼인 thread가 background에서 돈다. / 근데 ui는 main이다 몸통, 위에서 돈다 따라서 그리라고 통보하면 main에서 그리도록 요청해야한다.
    
    
    var newsData : Array<Dictionary<String, Any>>? //값이 비어있을 수 있어!
    
    
                
    func getNews(){ //애는 background에서 돈다
        let task = URLSession.shared.dataTask(with: URL(string:"https://newsapi.org/v2/top-headlines?country=us&apiKey=1692fcbbd09d46718671c45011e2bddb")!) {(data, response, error) in
            
            
            if let dataJson = data{
                
                //json parsing(변환)
                do {
                    let json =  try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    print(json)
                    //Dictionary
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    print(articles)
                    self.newsData = articles  //~.self를통해
                    
                    DispatchQueue.main.async { //,main에서 그려라
                        self.TableViewMain.reloadData() //data를 가져왔음을 통보.  main애서 돌아라~ 요청 해야함
                    }
                    
                    
//                    for(idx, value) in articles.enumerated(){
//                        //json 형태인지 확인해보기
//                        if let v = value as? Dictionary<String, Any>{
//                            print("\(v["title"])")
//                        }
//                    }
                    
         
                }
                catch{}
            }
        }
        task.resume()
    }
    
    
    
    // 아래 코드는 ch9까지의 코드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //2. 데이터 몇개인지.
        
        //ch10 에서 변경
        if let news = newsData{
            return news.count
        }
        else{
            return 0
        }
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
        
        
        //ch10 추가
        let idx = indexPath.row
        if let news = newsData{ //newsData가 비어있지 않다는것을 확신한 다음에
            let row = news[idx] //news의  indexPath의 row를 가져와서/ 그 뉴스의  숫자에 해당하는 번지수의 뉴스를 가져와서
            
            if let r = row as? Dictionary<String, Any>{ //row가(그 뉴스가)  딕셔너리 형태라면
//                print("\(v["title"])")
                
                //as? as! - 부모 자식 친자확인
                //타입을 안전하게 추론하는 as?와 강제로 변환하는 as!
                if let title = r["title"] as? String{
//                    cell.LabelText.text = "\(r["title"])" //출력해라! --> optional이라는 글을 벗겨내야함
                    cell.LabelText.text = title
                }
            }
        }
//        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
    
    //(1) tableview delegate 옵션 - 클릭 감지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK !!! \(indexPath.row)")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
        
        
        
        if let news = newsData{
            let row = news[indexPath.row]
            print("row :: \(row)")
            
            if let r = row as? Dictionary<String, Any> {
                if let imageUrl = r["urlToImage"] as? String{
                    controller.imageUrl = imageUrl
                }
                if let desc = r["description"] as? String {
                    controller.desc = desc
                }
            }
        }
        //이동! - 수동
        showDetailViewController(controller, sender: nil)
        
    }
    
    //(2) storyboard (segue)로 세팅 - 세그웨이 / override는 부모의 것을 물려받아
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "NewsDetail" == id { //해당 세그웨이의 값
            if let controller = segue.destination as? NewsDetailController { //destination이 NewsDetialController라면
                
                if let news = newsData{
                    if let indexPath = TableViewMain.indexPathForSelectedRow {
                        let row = news[indexPath.row]
                        print("row :: \(row)")
                        
                        if let r = row as? Dictionary<String, Any>{
                            if let imageUrl = r["urlToImage"] as? String{
                              controller.imageUrl = imageUrl
                            }
                            if let desc = r["description"] as? String {
                                controller.desc = desc
                            }
                        }
                    }
                }
            }
        }
        //이동! - 자동
    }
    
    
    //ch11. 할일
    //1. 디테일 (상세) 화면 만들기
    //2. 값을 보내기 2가지
    //(1) tableview delegate  (2) storyboard (segue)로 세팅
    //3. 화면 이동 (이동하기 전에 값을 미리 세팅해야한다!!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getNews()
    }

    
    //tableview는 테이블로 된 뷰 - 여러개의 행이 모여있는 목록 뷰(화면)
    //왜 쓰는가 ? 정갈하게 보여줄려고! ex)전화번호부
    
    //1. 데이터가 무엇인지 - 전화번호 목록
    //2. 데이터가 몇개인지 - 100,1000,10000개
    //3. (옵션) 데이터 행을 눌렀다. - 클릭했다.

}

