//
//  DashboardDummyData.swift
//  PetHomeStay
//
//  Created by Juan Diego Delgado Vargas on 13/10/2015.
//  Copyright © 2015 Pet Home Stay. All rights reserved.
//

import Foundation

class DashboardDummyData {

  static var thingsToDoCards = [DashboardCard]()
  static var bookedCards = [DashboardCard]()
  static var historyCards = [DashboardCard]()
  
  private static var PetNames = [String]() //Internal Structure
  private static var Dates = [String]() //Internal Structure
  private static var Messages = [Int]() //Internal Structure
  private static var Price = [Int]() //Internal Structure
  private static var Host = [DashboardHost]() //Internal Structure
  
  //#MARK: - Create Dummy Data
  class func createDummyData() {
    createPetNames()
    createDates()
    createMessages()
    createPrices()
    createHosts()
    createCards()
  }
  
  private class func createPetNames() {
    //Create Pet Names Array...
    PetNames.append("Ozzie")
    PetNames.append("Shiro")
    PetNames.append("Luna")
    PetNames.append("Nyx")
    PetNames.append("Mickey")
    PetNames.append("Oracle")
    PetNames.append("Scott")
    PetNames.append("Snoopy")
    PetNames.append("Yoshi")
    PetNames.append("Leonard")
  }
  
  private class func createDates() {
    //Create Dates Array...
    Dates.append("Nov 2 - Nov 5")
    Dates.append("Nov 5 - Nov 6")
    Dates.append("Nov 12 - Nov 15")
    Dates.append("Nov 22 - Nov 24")
    Dates.append("Dec 1 - Dec 2")
    Dates.append("Dec 3")
    Dates.append("Dec 5 - Dec 7")
    Dates.append("Dec 10 - Dec 12")
    Dates.append("Dec 24 - Jan 2")
    Dates.append("Dec 27 - Dec 29")
  }
  
  private class func createMessages() {
    //Create Messages Array...
    Messages.append(5)
    Messages.append(15)
    Messages.append(2)
    Messages.append(23)
    Messages.append(0)
    Messages.append(1)
    Messages.append(1)
    Messages.append(4)
  }
  
  private class func createPrices() {
    //Create Prices Array...
    Price.append(75)
    Price.append(55)
    Price.append(120)
    Price.append(60)
    Price.append(30)
    Price.append(47)
    Price.append(32)
    Price.append(85)
  }
  
  private class func createHosts() {
     Host.append(DashboardHost(name: "Aaron", phone: "0423227728"))
     Host.append(DashboardHost(name: "Betty", phone: "0424578421"))
     Host.append(DashboardHost(name: "Edward", phone: "0427514896"))
     Host.append(DashboardHost(name: "Caroline", phone: "0417748556"))
     Host.append(DashboardHost(name: "Helena", phone: "0433587769"))
  }
  
  private class func createCards() {
    //Create Cards
    thingsToDoCards.append(createDashboardCard(EDashboardCardType.Booking, numberOfPets: 1))
    thingsToDoCards.append(createDashboardCard(EDashboardCardType.Booking, numberOfPets: 1))
    thingsToDoCards.append(createDashboardCard(EDashboardCardType.Review, numberOfPets: 1))
    thingsToDoCards.append(createDashboardCard(EDashboardCardType.Booking, numberOfPets: 1))
    thingsToDoCards.append(createDashboardCard(EDashboardCardType.Booking, numberOfPets: 1))
  }
  
  private class func createDashboardCard(type: EDashboardCardType, numberOfPets: Int) -> DashboardCard {
    let date = Dates.removeFirst()
    let message = Messages.removeFirst()
    let price = Price.removeFirst()
    let host = Host.removeFirst()
    
    let card = DashboardCard(type: type, date: date, messages: message, price: price, host: host)
    
    for index in 1...numberOfPets {
      let petName = PetNames.removeFirst()
      
      card.pets.append(Pet(id: index, name: petName, image: nil))
    }
    
    return card
  }
}