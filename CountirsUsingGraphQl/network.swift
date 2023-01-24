//
//  network.swift
//  CountirsUsingGraphQl
//
//  Created by NourAllah Ahmed on 24/01/2023.
//

import Foundation
import Apollo

class Network{
    static var shared = Network()
    private init(){}
    
    lazy var apollo = ApolloClient(url:  URL(string: "https://countries.trevorblades.com/")!)
    
}
