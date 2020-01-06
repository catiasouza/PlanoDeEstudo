//
//  StandyManager.swift
//  PlanoDeEstudos
//
//  Created by Catia Miranda de Souza on 06/01/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation
import UserNotifications

class StudyManager{
    static let shared = StudyManager()
    let ud = UserDefaults.standard
    var studyPlans: [StudyPlan] = [] // array da classe
    
    private init(){
        if let data = ud.data(forKey: "studyPlans"),let plans = try?
            JSONDecoder().decode([StudyPlan].self, from: data){
            self.studyPlans = plans
        }
    }
    func savePlans() {
        if let data = try? JSONEncoder().encode(studyPlans){
            ud.set(data, forKey: "studyPlans")
        }
    }
    func addPlan(_ studyPlan: StudyPlan){
        studyPlans.append(studyPlan)
        savePlans()
    }
    func removePlan(at index: Int)  {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [studyPlans[index].id])
        studyPlans.remove(at: index)
        savePlans()
    }
    func setPlanDone(id: String) {
        if let studyPlan = studyPlans.first(where: {$0.id == id}){
            studyPlan.done = true
            savePlans()
        }
            
        
    }
}

