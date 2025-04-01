//
//  portfolioDataService.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/31/25.
//

import Foundation
import CoreData

class portfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "portfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error{
                print("erro loading core data \(error)")
            }
            self.getData()
        }
    }
    
    // PUBLIC
    
    func updatePortfolio(coin: coinModel, amount: Double){
        if let entity = savedEntities.first(where: { $0.coinID == coin.id}){
            
            if amount > 0{
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
            
        }
        
        // OR
        
//        if let entity = savedEntities.first(where: { savedEntities -> Bool in
//            return savedEntities.coinID == coin.id
//        }){
//            if amount > 0{
//                update(entity: entity, amount: amount)
//            } else {
//                delete(entity: entity)
//            }
//        }
        
    }
    
    // Private Section
    private func getData(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        do{
            savedEntities =  try container.viewContext.fetch(request)
        } catch {
            print("error in getting entities")
        }
    }
    
    private func add(coin: coinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
        } catch {
            print("error saving data")
        }
    }
    
    private func applyChanges(){
        save()
        getData()
    }
    
}
