//
//  DetailsScreen.swift
//  CountirsUsingGraphQl
//
//  Created by NourAllah Ahmed on 24/01/2023.
//

import SwiftUI

struct DetailsScreen: View {
    var countryCode : String
    @State var country : CountryDetailsQuery.Data.Country?
    var body: some View {
        VStack(alignment: .leading){
            if(country != nil){
                
                VStack(alignment: .center, spacing: 1.0, content: {
                    Text(country?.emoji ?? "")
                        .fontWeight(Font.Weight.heavy)
                        .font(.system(size: 100))
                })
                
                HStack{
                    VStack(alignment: .leading, spacing: 1.0, content: {

                    Text("Country Name:")
                        .fontWeight(Font.Weight.heavy)
                        .font(.system(size: 20))
                    Text(country?.name ?? "")
                        .fontWeight(Font.Weight.regular)
                        .font(.system(size: 30))
                    Text("Capital:").fontWeight(Font.Weight.heavy)
                           .font(.system(size: 20))
                    Text(country?.capital ?? "")
                       .fontWeight(Font.Weight.regular)
                       .font(.system(size: 30))
                    
                    Text("Languages:").fontWeight(Font.Weight.heavy).font(.system(size: 20))
                         Text(country?.languages.first?.name ?? "")
                             .fontWeight(Font.Weight.regular)
                             .font(.system(size: 30))
                    Text("Currency:").fontWeight(Font.Weight.heavy).font(.system(size: 20))
                    Text(country?.currency ?? "")
                        .fontWeight(Font.Weight.regular)
                        .font(.system(size: 30))
                    
                })
               
    
                
                Spacer()
                    
                }
                Spacer()
            }
            
        }
        .navigationTitle(country?.name ?? "")
        .onAppear(perform: {
        Network.shared.apollo.fetch(query: CountryDetailsQuery(id: countryCode ))
                    { result in
                        switch result {

                        case .success(let resultGraphQl):
                            if ((resultGraphQl.data?.country) != nil) {

                                DispatchQueue.main.async {
                                    country = resultGraphQl.data?.country!
                                }

                            }
                        case .failure(let error):
                            print(error)
                        }

                    }
        })
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(countryCode:  "")
    }
}
