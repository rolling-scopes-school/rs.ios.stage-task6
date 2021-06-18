import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    // MARK: - createDeck
    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        
        var newDeck: [Card] = []
        
        for suit in suits {
            for value in values  {
                let card = Card(suit: suit, value: value, isTrump: false)
                newDeck.append(card)
            }
        }
        
        return newDeck
    }

    // MARK: - shuffle()
    public mutating func shuffle() {
        var items = cards
        var shuffled = [Card]()

        for _ in 0..<items.count {
            let rand = Int.random(in: 0..<items.count)
            shuffled.append(items[rand])
            items.remove(at: rand)
        }
        
        if shuffled == cards {
            shuffle()
        } else {
            self.cards = shuffled
        }
    }
    
    // MARK: - defineTrump()
    public mutating func defineTrump() {
        trump = cards.last?.suit
        
        setTrumpCards(for: trump!)
    }
    
    // MARK: -
    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for player in players {
//            print(cards[(cards.count-6)...])
            player.hand = Array(cards[(cards.count-6)...])
//            print("player.hand = \(player.hand!)")
            cards = Array(cards[...(cards.count-7)])
        }
    }
    
    // MARK: -
    public mutating func setTrumpCards(for suit:Suit) {
        var cardsWithTrumps:[Card] = []
        
        for card in cards {
            if card.suit == trump {
                cardsWithTrumps.append(Card(suit: card.suit, value: card.value, isTrump: true))
            } else {
                cardsWithTrumps.append(Card(suit: card.suit, value: card.value, isTrump: false))
            }
        }
        
        cards = cardsWithTrumps
    }
}

