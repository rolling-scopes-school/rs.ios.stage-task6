//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        /// первый ходит игрок имеющий наименьшый козырь
        var playersWithTrump: [Player] = []
        if players.count < 2 {return nil}
//      Вefine have if player Trump card or no
        for player in players {
            if (player.hand?.filter{card in card.isTrump == true}.count)! > 0 {
                playersWithTrump.append(player)
            }
        }
        // If we have one player with trump, this be our first Player
        if playersWithTrump.count == 1 {
            return playersWithTrump.first
        } else if playersWithTrump.count > 1 {
            // case, when often playrs with trump
            var firstPlayer: Player = playersWithTrump.first!
            for (index, player) in playersWithTrump.enumerated() {
                if index == 0 {
                    continue
                }
                
                let firstPlayerTrump = (firstPlayer.hand?.filter{card in card.isTrump == true}.sorted{$0.checkValue(card: $1)}[0])!
                let playerTrump = (player.hand?.filter{card in card.isTrump == true}.sorted{$0.checkValue(card: $1)}[0])!
                
                if playerTrump.value.rawValue < firstPlayerTrump.value.rawValue {
                    firstPlayer = player
                }
            }
            return firstPlayer
        } else {
            //case when not players with trump
            var firstPlayer: Player = players.first!
            var minCard: Card = (players.first!.hand?.sorted{ $0.checkValue(card: $1) }.first!)!
            
            for player in players {
                let playerMinCard: Card = (player.hand?.sorted{ $0.checkValue(card: $1) }.first!)!
                
                if minCard.checkValue(card: playerMinCard) {
                    firstPlayer = player
                    minCard = playerMinCard
                }
            }
            return firstPlayer
        }
//        return nil
    }
}
