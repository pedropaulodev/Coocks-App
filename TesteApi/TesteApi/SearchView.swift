import SwiftUI

// View principal que exibe a lista de bebidas
struct SearchView: View {
    let names = ["Julian", "Josh", "Rhonda", "Ted"]
    
    
    @State private var drinks: [Drink] = []
    @State private var searchText: String = ""
    @State private var resultText: String = ""
    @State private var isLoading = false
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    
    private let caracters = Array(97...122).compactMap { UnicodeScalar($0) }
    
    var body: some View {
        NavigationStack {
            if searchText.isEmpty{
                VStack{
                    ScrollView{
                        ForEach(caracters, id: \.self) { scalar in
                            //                            Text(String(scalar).uppercased())
                            //                                .font(.largeTitle)
                            //                                .fontWeight(.bold)
                            Tela2(tipo: "caracter", name: String(scalar))
                        }
                    }
                }
            } else if !resultText.isEmpty{
                Tela2(tipo: "name", name: resultText)
            }
        }.searchable(text: $searchText)
            .onSubmit(of: .search) {
                resultText = searchText
            }
    }
}

// Preview da ContentView
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
