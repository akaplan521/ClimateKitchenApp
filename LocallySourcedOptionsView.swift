//
//  LocallySourcedOptions.swift
//  SearchTestingApp
//

//import SwiftUI
//import UIKit
//import CoreLocation
//import CoreLocationUI
//
//struct LocallySourcedOptionsView: View {
//    var body: some View {
//        VStack {
//            // Title
//            Text("Locally-Sourced Options")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//                .padding(.top, 50)
//            
//            // Market info
//            ScrollView {
//                VStack(alignment: .leading, spacing: 20) {
//                    Group {
//                        Text("City Market")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                        Text("Distance: 0.9 miles")
//                        Text("82 S. Winooski Ave\nBurlington, VT")
//                        Text("Hours:\nMonday - Sunday, 7am-9pm")
//                    }
//                    
//                    Group {
//                        Text("Always Full")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                        Text("Distance: 1.1 miles")
//                        Text("1128 Williston Rd\nSouth Burlington, VT")
//                        Text("Hours:\nMonday 10am-8pm\nTuesday-Wednesday 10:30am-8pm\nThursday-Sunday 10am-8pm")
//                    }
//                    
//                    Group {
//                        Text("India Bazaar")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                        Text("Distance: 1.5 miles")
//                        Text("1293 Williston Rd\nSouth Burlington, VT")
//                        Text("Hours:\nMonday - Saturday, 11am-7pm\nSunday 12-5pm")
//                    }
//                    
//                    Group {
//                        Text("Burlington Farmers Market")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                        Text("Distance: 1.5 miles")
//                        Text("345 Pine Street\nBurlington, VT")
//                        Text("Hours:\nSaturday, 9am-2pm\n\n")
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top, 20)
//            }
//            
//            BottomNavigationBar()
//        }
//        //.background(Color(red: 241/255, green: 230/255, blue: 218/255))
//        .edgesIgnoringSafeArea(.bottom)
//    }
//}


// this is for the API (if developed)
//
//  LocallySourcedOptions.swift
//  SearchTestingApp
//

//
//  LocallySourcedOptions.swift
//  SearchTestingApp
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct LocallySourcedOptionsView: View {
    @State private var location: CLLocationCoordinate2D?
    @State private var markets: [Market] = []
    @State private var isFetchingLocation = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if let location = location {
                    Text("Your Location: \(location.latitude), \(location.longitude)")
                        .padding()
                        .font(.headline)
                    
                    Button("Fetch Local Markets") {
                        fetchLocalMarkets(lat: location.latitude, lon: location.longitude)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    
                    if isFetchingLocation {
                        ProgressView("Fetching data...")
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List(markets) { market in
                            VStack(alignment: .leading) {
                                Text(market.listingName)
                                    .font(.headline)
                                if let address = market.locationAddress {
                                    Text(address)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                if let phone = market.contactPhone {
                                    Text("Phone Number: \(phone)")
                                        .font(.footnote)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("Enable location access to find local markets")
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        LocationButton(.currentLocation) {
                            requestLocation()
                        }
                        .frame(height: 44)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Local Markets")
        }
    }
    
    //user Location
    func requestLocation() {
        let locationManager = LocationManager.shared
        locationManager.requestLocation { result in
            switch result {
            case .success(let coord):
                self.location = coord
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchLocalMarkets(lat: Double, lon: Double) {
        isFetchingLocation = true
        let urlString = "https://www.usdalocalfoodportal.com/api/farmersmarket/?apikey=Br04GXHreQ&x=\(lon)&y=\(lat)&radius=30"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid API URL."
            isFetchingLocation = false
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1", forHTTPHeaderField: "User-Agent")


        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isFetchingLocation = false
                
                if let error = error {
                    errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                    print("Headers: \(httpResponse.allHeaderFields)")
                }
                
                guard let data = data else {
                    errorMessage = "No data received."
                    return
                }
                print(urlString)
                print("Raw response: \(String(data: data, encoding: .utf8)?.prefix(300) ?? "Invalid Data")")
                
                do {
                    let decodedResponse = try JSONDecoder().decode(LocalMarketsResponse.self, from: data)
                    self.markets = decodedResponse.data
                    if self.markets.isEmpty {
                        errorMessage = "No markets found in this area."
                    }
                } catch {
                    errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }


}

// MARK: - Response Structs
struct LocalMarketsResponse: Codable {
    let data: [Market]
}

struct Market: Identifiable, Codable {
    var id: String { listingId } //listingId as identifier
    let directoryType: String
    let directoryName: String
    let updateTime: String
    let listingImage: String
    let listingId: String
    let listingName: String
    let listingDesc: String?
    let briefDesc: String?
    let contactName: String?
    let contactEmail: String?
    let contactPhone: String?
    let mediaWebsite: String?
    let mediaFacebook: String?
    let mediaTwitter: String?
    let mediaInstagram: String?
    let mediaPinterest: String?
    let mediaYouTube: String?
    let locationAddress: String?
    let locationCity: String
    let locationState: String
    let locationZipcode: String
    let distance: String?

    enum CodingKeys: String, CodingKey {
        case directoryType = "directory_type"
        case directoryName = "directory_name"
        case updateTime = "updatetime"
        case listingImage = "listing_image"
        case listingId = "listing_id"
        case listingName = "listing_name"
        case listingDesc = "listing_desc"
        case briefDesc = "brief_desc"
        case contactName = "contact_name"
        case contactEmail = "contact_email"
        case contactPhone = "contact_phone"
        case mediaWebsite = "media_website"
        case mediaFacebook = "media_facebook"
        case mediaTwitter = "media_twitter"
        case mediaInstagram = "media_instagram"
        case mediaPinterest = "media_pinterest"
        case mediaYouTube = "media_youtube"
        case locationAddress = "location_address"
        case locationCity = "location_city"
        case locationState = "location_state"
        case locationZipcode = "location_zipcode"
        case distance
    }
}




// MARK: - Location Manager

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var completion: ((Result<CLLocationCoordinate2D, Error>) -> Void)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(.success(location.coordinate))
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
        completion = nil
    }
}
