//
//  Menu.swift
//  Little Lemon Final Project
//
//  Created by Donald Dang on 7/2/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    let persistence = PersistenceController.shared
    /*
     This is an alternative implementation that does the same thing, but doesn't contain the resume to start task stuff. I prefer using this on real applications as opposed to the way that Coursera wants us to do it (as well as making this into a generic, but for the purposes of this course we use the function below.
    func getMenuData() async throws {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        let url = URL(string: urlString)!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodedData = try JSONDecoder().decode(MenuList.self, from: data)
        } catch {
            
        }
        
    }
     
     */
    
    func getMenuData(completed: @escaping () -> ()) {
        persistence.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        let url = URL(string: urlString)!
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data{
                do {
                    let decodedData = try? JSONDecoder().decode(MenuList.self, from: data)
                    //print(decodedData)
                    if let menuItems = decodedData?.menu {
                        for menuItem in menuItems {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                                                        dish.image = menuItem.image
                                                        dish.price = menuItem.price
                        }
                    }
                    
                    try? viewContext.save()
                } catch {
                    print("error decoding data.")
                }
            } else {
                print("there is no data.")
            }
            
            completed()
        }.resume()
    }
    
    private func filterPredicate(for category: String) -> NSPredicate {
        if category == selectedCategory {
            return buildPredicate() // Use the existing predicate when the same category is selected again
        } else {
            selectedCategory = category // Update the selected category
            switch category {
            case "Starters":
                return NSPredicate(format: "title == %@", "Greek Salad")
            case "Mains":
                return NSPredicate(format: "title IN %@", ["Bruschetta", "Grilled Fish", "Pasta"])
            case "Desserts":
                return NSPredicate(format: "title == %@", "Lemon Desert")
            case "Drinks":
                return NSPredicate(value: false) // Empty predicate to filter an empty array
            default:
                return NSPredicate(value: true) // Default predicate, show all dishes
            }
        }
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector:  #selector(NSString.localizedStandardCompare))]
    }
    
    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var selectedCategory: String?
    
    var body: some View {
        VStack {
            Image("littleLemon")
            ZStack {
                Color(hex: "495E57")
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 200)
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Little Lemon")
                                .foregroundColor(.yellow)
                                .font(.largeTitle)
                            Text("Chicago")
                                .foregroundColor(.white)
                                .font(.title2)
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist")
                                .foregroundColor(.white)
                                .font(.body)
                        }
                        
                        Image("food")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    TextField("Search Menu", text: $searchText)
                        .font(Font.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "495E57"))
                        .background(Color(hex: "EDEFEE"))
                        
                }
            }
            .padding()
            .background(Color(hex: "495E57"))
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(dish.title ?? "")
                                Text("$\(dish.price ?? "")")
                            }
                            
                            Spacer()
                            
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                Color.white
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            getMenuData {
                //
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
