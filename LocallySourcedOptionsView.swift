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
        let urlString = "https://www.usdalocalfoodportal.com/api/farmersmarket/?apikey=QoX97uf0GS&x=\(lon)&y=\(lat)&radius=30"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid API URL."
            isFetchingLocation = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isFetchingLocation = false
                if let error = error {
                    errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    errorMessage = "No data received."
                    return
                }
                print("Raw response: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
                do {
                    let decodedResponse = try JSONDecoder().decode(LocalMarketsResponse.self, from: data)
                    self.markets = decodedResponse.data
                    print("cant decode data")
                    if self.markets.isEmpty {
                        errorMessage = "No markets found in this area."
                    }
                } catch {
                    errorMessage = "Decoding error: \(error.localizedDescription)"
                    print("entering cant decode block")
                    //print("Raw response: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
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
