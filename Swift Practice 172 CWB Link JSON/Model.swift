//
//  Model.swift
//  Swift Practice 172 CWB Link JSON
//
//  Created by Dogpa's MBAir M1 on 2022/8/31.
//

import Foundation


//台灣行政區JSON第一層
struct TaiwanDist: Decodable {
    let name: String                //縣市名稱
    let districts: [DistrictInfo]   //縣市內的鄉鎮行政區型別為DistrictInfo
}

//台灣行政區JSON第二層
struct DistrictInfo: Decodable {
    let zip: String                 //鄉鎮行政區的郵遞區號
    let name: String                //鄉鎮行政區的名字
}


//CWB修改後JSON第一層
struct CWB: Decodable {
    let county: String              //縣市名稱
    let district: [CWBDistDetail]
}

//CWB修改後JSON第二層
struct CWBDistDetail: Decodable {
    let ID : String                 //網頁連結的Index
    let Name: DistName
    let RID : String
}

//CWB修改後JSON第三層
struct DistName : Decodable {
    let C: String                   //鄉鎮市區中文名稱
    let E: String                   //鄉鎮市區英文名稱
}

///解析JSON
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
