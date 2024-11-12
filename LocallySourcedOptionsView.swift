import SwiftUI
import UIKit

// Catie: Local options page
struct LocallySourcedOptionsView: View {
    var body: some View {
        VStack {
            // Title
            Text("Locally-Sourced Options")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            // Market info
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("City Market")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 0.9 miles")
                        Text("82 S. Winooski Ave\nBurlington, VT")
                        Text("Hours:\nMonday - Sunday, 7am-9pm")
                    }
                    
                    Group {
                        Text("Always Full")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 1.1 miles")
                        Text("1128 Williston Rd\nSouth Burlington, VT")
                        Text("Hours:\nMonday 10am-8pm\nTuesday-Wednesday 10:30am-8pm\nThursday-Sunday 10am-8pm")
                    }
                    
                    Group {
                        Text("India Bazaar")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 1.5 miles")
                        Text("1293 Williston Rd\nSouth Burlington, VT")
                        Text("Hours:\nMonday - Saturday, 11am-7pm\nSunday 12-5pm")
                    }
                    
                    Group {
                        Text("Burlington Farmers Market")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 1.5 miles")
                        Text("345 Pine Street\nBurlington, VT")
                        Text("Hours:\nSaturday, 9am-2pm\n\n")
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            
            BottomNavigationBar()
        }
        //.background(Color(red: 241/255, green: 230/255, blue: 218/255))
        .edgesIgnoringSafeArea(.all)
    }
}
