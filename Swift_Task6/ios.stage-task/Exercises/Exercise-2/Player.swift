//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        if let hand = self.hand {
            for selfCard in hand {
                if card.value == selfCard.value {
                    return true
                }
            }
        }
        
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        if let hand = self.hand {
            for selfCard in hand {
                for key in table.keys {
                    if key.value == selfCard.value {
                        return true
                    }
                }
                for val in table.values {
                    if val.value == selfCard.value {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}
