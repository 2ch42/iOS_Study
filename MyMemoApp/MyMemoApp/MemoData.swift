//
//  Memo.swift
//  MyMemoApp
//
//  Created by 이창현 on 9/6/24.
//

import Foundation

class Memo {
    var date: Date
    var description: String
    
    init(date: Date, description: String) {
        self.date = date
        self.description = description
    }
}

extension Memo {
    static var sampleList: [Memo] = [
        Memo(date: Date(), description: "This is Sample Data. I want to get a job. I want to go home."),
        Memo(date: Date() - 86400, description: "Second sample Memo of this app. Arsenal is king in EPL. This is true."),
        Memo(date: Date() - 200000, description: "This is third memo."),
        Memo(date: Date(), description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
        Memo(date: Date(), description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
        Memo(date: Date(), description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."),
        Memo(date: Date() - 86400, description: """
            We’re back at Sobha Realty Training Centre to begin our preparations for Brighton & Hove Albion this weekend.
            
            Fresh off the back of our 2-0 win away to Aston Villa, we’ve been straight back to work in the late August sunshine.
            
            Watch how we’ve kicked off the week by pressing play on Inside Training above.
            
            Copyright 2024 The Arsenal Football Club Limited. Permission to use quotations from this article is granted subject to appropriate credit being given to www.arsenal.com as the source.
            """),
        Memo(date: Date() - 4000000, description: """
            Due to the expansion of both the Champions League and the Europa League, two additional European matchweeks have been added to the calendar, which coincide with the Carabao Cup third round dates, which be staggered the weeks commencing 16th and 23rd September.
            """),
        Memo(date: Date(), description: """
            To ensure there is no clash of fixture dates for teams playing in these competitions, two bowls will be used for the draw - bowl one will contain the six teams who have reached the Champions League and Europa League - including ourselves - while bowl two has the other 26 clubs. This means that Manchester City, Liverpool, Aston Villa, Manchester United, Tottenham and ourselves cannot face each other in the third round.
            """),
        Memo(date: Date() - 10000000, description: """
            Those six teams will be pre-drawn to determine whether they’ll be at home or away for the third round, and slotted separately into the first six ties. Then when the main draw gets underway, teams from pot 2 will be paired with one European team to complete the first six ties, and then the remaining 10 will be drawn from the rest of the teams in pot 2.
            """)
    ]
}

extension Memo: Hashable, Comparable, Equatable {
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        lhs.date == rhs.date && lhs.description == rhs.description ? true : false
    }
    
    static func < (lhs: Memo, rhs: Memo) -> Bool {
        lhs.date < rhs.date ? false: true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(description)
    }
}

