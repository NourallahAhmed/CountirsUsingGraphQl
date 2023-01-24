    //
    //  ContentView.swift
    //  CountirsUsingGraphQl
    //
    //  Created by NourAllah Ahmed on 24/01/2023.
    //

    import SwiftUI

    struct ContentView: View {
        @State var countries :[AllCountriesQuery.Data.Country] = []
        var body: some View {
            NavigationView{
                List( countries, id: \.code ){ country in
                    
                    NavigationLink (destination: DetailsScreen(countryCode:  country.code ), label: {
                        HStack{
                            Text(country.emoji)
                                .fontWeight(Font.Weight.regular)
                                .font(.system(size: 35))
                            
                            Text(country.name)  .fontWeight(Font.Weight.regular)
                                .font(.system(size: 25))
                            
                        }})
                }
                .listStyle(.plain)
                .navigationTitle("Countries")
                    
            }.onAppear(perform: {
                Network.shared.apollo.fetch(
                    query: AllCountriesQuery()
                ){ result in
                    
                    switch result{
                        
                    case .success(let graphQlResult):
                        
                        if ((graphQlResult.data?.countries) != nil) {
                        
                            DispatchQueue.main.async {
                            
                            self.countries = graphQlResult.data?.countries ?? []
                            }
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                }}
            

            
            
            )
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
