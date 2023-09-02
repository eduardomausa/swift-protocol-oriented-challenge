import UIKit

enum FuelType : String {
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case electric = "Eletric"
    case hybrid = "Hybrid"
}

protocol Vehicle {
    func start()
    func stop()
    var model: String { get }
    var fuelType: FuelType { get }
}

protocol EnvironmentalFriendly {
    var isEnvironmentalFriendly: Bool { get }
}

extension Vehicle {
    func start() {
        print("Starting the vehicle!")
    }
    
    func stop() {
        print("Stopping the vehicle!")
    }
}

struct Car: Vehicle, EnvironmentalFriendly {
    var fuelType: FuelType
    var isEnvironmentalFriendly: Bool
    var model: String
    
    func start() {
        print("Starting the \(model)!")
    }
    
    func stop() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            print("Stopping the \(model)!")
        } catch {
            print("An error occurred: \(error)")
        }
    }
}

struct Bus: Vehicle, EnvironmentalFriendly {
    var isEnvironmentalFriendly: Bool
    var fuelType: FuelType
    var model: String
}

let car1 = Car(fuelType: .gasoline, isEnvironmentalFriendly: false, model: "911 Carrera")
car1.start()
car1.stop()

let car2 = Car(fuelType: .hybrid, isEnvironmentalFriendly: true, model: "Hybrid Fusion")
let car3 = Car(fuelType: .hybrid, isEnvironmentalFriendly: true, model: "GLC 250")

let bus1 = Bus(isEnvironmentalFriendly: false, fuelType: .diesel, model: "Marcopolo")
bus1.start()
car1.stop()

let bu2 = Bus(isEnvironmentalFriendly: false, fuelType: .diesel, model: "M.Benz")

let vehicles: [Vehicle] = [
    Car(fuelType: .gasoline, isEnvironmentalFriendly: false, model: "911 Carrera"),
    Car(fuelType: .hybrid, isEnvironmentalFriendly: true, model: "Hybrid Fusion"),
    Car(fuelType: .hybrid, isEnvironmentalFriendly: true, model: "GLC 250"),
    Bus(isEnvironmentalFriendly: false, fuelType: .diesel, model: "Marcopolo"),
    Bus(isEnvironmentalFriendly: false, fuelType: .diesel, model: "M.Benz")
]

let environmentalFriendlyVehicles = vehicles.filter { vehicle in
    if let environmentalFriendly = vehicle as? EnvironmentalFriendly {
        return environmentalFriendly.isEnvironmentalFriendly
    }
    return false
}

print()
print("Environmental Friendly Cars")
for car in environmentalFriendlyVehicles {
    print("Model: \(car.model), FuelType: \(car.fuelType.rawValue)")
}

let notEnvironmentalFriendlyVehicles = vehicles.filter { vehicle in
    if let environmentalFriendly = vehicle as? EnvironmentalFriendly {
        return !environmentalFriendly.isEnvironmentalFriendly
    }
    return false
}

print()
print("Not Environmental Friendly Cars")
for car in notEnvironmentalFriendlyVehicles {
    print("Model: \(car.model), FuelType: \(car.fuelType.rawValue)")
}

func main() async {
    car1.start()
    await car1.stop()
}

Task {
    await main()
}
