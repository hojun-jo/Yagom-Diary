//
//  Weather.swift
//  Diary
//
//  Created by 조호준 on 2023/09/14.
//

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
