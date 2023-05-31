//
//  GenericsTest.swift
//  SwiftUI01
//
//  Created by we on 2023/05/25.
//

import SwiftUI

protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

extension CustomStringConvertible where Self: Bird {
    var description: String {
        canFly ? "I can fly" : "Guess I'll just sit here :["
    }
}

class Motorcycle {
    init(name: String) {
        self.name = name
        speed = 200.0
    }
    
    var name: String
    var speed: Double
}

// 1
protocol Racer {
    var speed: Double { get }  // speed is the only thing racers care about
}

// 2
extension FlappyBird: Racer {
    var speed: Double {
        airspeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        airspeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        42  // full waddle speed
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        canFly ? airspeedVelocity : 0.0
    }
}

extension Motorcycle: Racer {}

// 3


protocol Flyable {
    var airspeedVelocity: Double { get }
}
struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airspeedVelocity: Double {
        3 * flappyFrequency * flappyAmplitude
    }
}
struct Penguin: Bird {
    let name: String
}

struct SwiftBird: Bird, Flyable {
    var name: String { "Swift \(version)" }
    let version: Double
    private var speedFactor = 1000.0
    
    init(version: Double) {
        self.version = version
    }
    
    // Swift is FASTER with each version!
    var airspeedVelocity: Double {
        version * speedFactor
    }
}
extension Bird {
    // Flyable birds can fly!
    var canFly: Bool { self is Flyable }
}

enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}

extension UnladenSwallow {
    var canFly: Bool {
        self != .unknown
    }
}

func topSpeed<RacersType: Sequence>(of racers: RacersType) -> Double
    /*2*/ where RacersType.Iterator.Element == Racer {
  // 3
  racers.max(by: { $0.speed < $1.speed })?.speed ?? 0.0
}

extension Sequence where Iterator.Element == Racer {
  func topSpeed() -> Double {
    self.max(by: { $0.speed < $1.speed })?.speed ?? 0.0
  }
    func bottomSpeed() -> Double {
      self.min(by: { $0.speed < $1.speed })?.speed ?? 0.0
    }

    func meanSpeed() -> Double {
        var count: Int = 0
        var sum: Double = 0.0
        for racer in self {
            count += 1
            sum += racer.speed
        }
        return sum / Double(count)
    }
}

protocol Score: Comparable {
  var value: Int { get }
}

struct RacingScore: Score {
  let value: Int
  
  static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
    lhs.value < rhs.value
  }
}

struct Date1 {
    let year: Int
    let month: Int
    let day: Int
}
extension Date1: Comparable {
    static func < (lhs: Date1, rhs: Date1) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        } else if lhs.month != rhs.month {
            return lhs.month < rhs.month
        } else {
            return lhs.day < rhs.day
        }
    }
}
struct GenericsTest: View {
    let racers: [Racer] =
    [UnladenSwallow.african,
     UnladenSwallow.european,
     UnladenSwallow.unknown,
     Penguin(name: "King Penguin"),
     SwiftBird(version: 5.1),
     FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
     Motorcycle(name: "Giacomo")]
    
    var body: some View {
        VStack {
            Text("\(topSpeed(of: racers))")
            Text("\(topSpeed(of: racers[1...3]))")
            Text("\(racers.topSpeed())")
            Text("\(racers[1...3].topSpeed())")
            Text("\(racers.bottomSpeed())")
            Text("\(racers.meanSpeed())")
            Text("\(RacingScore(value: 130) == RacingScore(value: 130) ? "true" : "false")")
            Text("\(Date1(year: 100, month: 200, day: 300) == Date1(year: 100, month: 200, day: 300) ? "true" : "false")")
        }
    }
    
//    func topSpeed(of racers: [Racer]) -> Double {
//      racers.max(by: { $0.speed < $1.speed })?.speed ?? 0.0
//    }
}

struct GenericsTest_Previews: PreviewProvider {
    static var previews: some View {
        GenericsTest()
    }
}
