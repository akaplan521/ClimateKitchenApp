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
                        Text("Market #1")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 4 miles")
                        Text("Hours: Monday 8-5\nTuesday 8-5\nWednesday 8-9\n...")
                    }
                    
                    Group {
                        Text("Market #2")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 9 miles")
                        Text("Hours: Monday 7-10\nTuesday 8-11\nWednesday 8-10\n...")
                    }
                    
                    Group {
                        Text("Market #3")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Distance: 146 miles")
                        Text("Hours: Monday 1-5\nTuesday 3-5\nWednesday 11-3\n...")
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
