//
//  ConvertViewModel.swift
//  Swift Practice 172 CWB Link JSON
//
//  Created by Dogpa's MBAir M1 on 2022/8/31.
//

import Foundation

final class ConvertViewModel: ObservableObject {
    @Published var taiwanCityAndDistArray = [TaiwanDist]()
    @Published var cwbCityAndDistArray = [CWB]()
    @Published var cwbIndexStr = """
    
    """
    
    //解析台灣行政區的JSON
    //解析透過Chrome開發者拿到的中央氣象局JSON
    //建立自定義的String當成字串使用
    func decodeJSON() {
        taiwanCityAndDistArray = load("taiwanDistrictsZip AndName.json")     //台灣行政區
        cwbCityAndDistArray = load("ConvertCWBInfoFromChrome.json")                 //中央氣象局
        matchDistAndCWBID()
    }
    
    func matchDistAndCWBID () {
        cwbIndexStr = """
        
        """
        var firstDist = 0
        var calculateDIst = 0
        
        //第一層巢狀迴圈先判斷兩者的相同縣市建立字串
        for tw in 0..<taiwanCityAndDistArray.count {
            for cwb in 0..<cwbCityAndDistArray.count {
                cwbIndexStr = """
                
                """
                if taiwanCityAndDistArray[tw].name == cwbCityAndDistArray[cwb].county {
                    print("開始比對\(taiwanCityAndDistArray[tw].name)")
                    let cityName = """
                    {
                        "name": "\(taiwanCityAndDistArray[tw].name)",
                        "districts": [
                    
                    """
                    cwbIndexStr += cityName
                    print(cwbIndexStr)
                    firstDist = 0
                    
                    //第二層巢狀迴圈判斷鄉鎮市區，一樣的取中央氣象局的值建立字串
                    for twDist in 0..<taiwanCityAndDistArray[tw].districts.count {
                        for cwbDist in 0..<cwbCityAndDistArray[cwb].district.count {
                            if taiwanCityAndDistArray[tw].districts[twDist].name == cwbCityAndDistArray[cwb].district[cwbDist].Name.C {
                                print("資料配對成功：台灣JSON\(taiwanCityAndDistArray[tw].districts[twDist].name) CWB JSON \(cwbCityAndDistArray[cwb].district[cwbDist].Name.C) CWBID \(cwbCityAndDistArray[cwb].district[cwbDist].ID)")
                                firstDist += 1
                                if firstDist != cwbCityAndDistArray[cwb].district.count  {
                                    let distNameAndIndex = """
                                        {
                                                "cwbIndex": "\(cwbCityAndDistArray[cwb].district[cwbDist].ID)"
                                                "name": "\(taiwanCityAndDistArray[tw].districts[twDist].name)"
                                        },
                                    
                                    """
                                    cwbIndexStr += distNameAndIndex
                                }else{
                                    let distNameAndIndex = """
                                        {
                                                "cwbIndex": "\(cwbCityAndDistArray[cwb].district[cwbDist].ID)"
                                                "name": "\(taiwanCityAndDistArray[tw].districts[twDist].name)"
                                        }
                                    
                                    """
                                    cwbIndexStr += distNameAndIndex
                                }
                                calculateDIst += 1
                            }
                        }
                    }
                    let finishStr = """
                            ]
                    },
                    """
                    cwbIndexStr += finishStr
                    print(cwbIndexStr)          //JSON格式最後要Copy的地方
                }
            }
        }
        
        print("配對成功總數 ：\(calculateDIst)")   //判斷比對後的行政區是否為368(台灣現行所有鄉鎮市區總數)
        
    }
}


/*
 
 for tw in 0..<taiwanCityAndDistArray.count {
 for cwb in 0..<cwbCityAndDistArray.count {
 
 if taiwanCityAndDistArray[tw].name == cwbCityAndDistArray[cwb].county {
 
 //print(cwbIndexStr)
 firstDist = 0
 for twDist in 0..<taiwanCityAndDistArray[tw].districts.count {
 for cwbDist in 0..<cwbCityAndDistArray[cwb].district.count {
 if taiwanCityAndDistArray[tw].districts[twDist].name == cwbCityAndDistArray[cwb].district[cwbDist].Name.C {
 //print("資料配對成功：台灣JSON\(taiwanCityAndDistArray[tw].districts[twDist].name) CWB JSON \(cwbCityAndDistArray[cwb].district[cwbDist].Name.C) CWBID \(cwbCityAndDistArray[cwb].district[cwbDist].ID)")
 
 print("\"\(taiwanCityAndDistArray[tw].name)\(taiwanCityAndDistArray[tw].districts[twDist].name)\" : \"\(cwbCityAndDistArray[cwb].district[cwbDist].ID)\",")
 
 }
 }
 
 
 //print(cwbIndexStr)          //JSON格式最後要Copy的地方
 }
 }
 }
 
 
 }
 */
