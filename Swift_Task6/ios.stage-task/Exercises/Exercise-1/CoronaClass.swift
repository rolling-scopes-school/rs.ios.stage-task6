import Foundation

class CoronaClass {
    
     var seats = [Int]()
    var desksCount:Int
    
     init(n: Int) {
        desksCount = n-1
     }
     
    // MARK: - func seat() implementation
     func seat() -> Int {
        if seats.isEmpty {
            seats.append(0)
            return 0
        }
                
        if seats.count == 1 {
            let opposite: Int
            if (desksCount - seats.first!) > seats.first! {
                opposite = desksCount
            } else {
                opposite = 0
            }
            
            seats.append(opposite)
            return opposite
        }
        
        var length = 0
        var minDistance = -1
        var range = [0, 0]
        
        // check case when first element loss
        if seats.first! > length {
            length = seats.first!
            range = [0, 0]
        }
        
        for i in 0...seats.count-2 {
            let currentLength = seats[i+1] - seats[i]
            let currentIdx = Int((seats[i+1] + seats[i]) / 2)
            let currentMinDistance = min(seats[i+1] - currentIdx,                                    currentIdx - seats[i])
            
            if currentLength > length && currentMinDistance > minDistance {
                length = seats[i+1] - seats[i]
                range = [seats[i], seats[i+1]]
                minDistance = currentMinDistance
            }
        }
        // check case when last element loss
        if desksCount - seats.last! > length {
            range = [desksCount, desksCount]
        }
        
        
        let idx = Int(Double(range[0]+range[1]) / 2)
        seats.append(idx)
        seats.sort()
        return idx
     }
     
     // MARK: - func leave() implementation
     func leave(_ p: Int) {
        seats.remove(at: seats.firstIndex(of: p)!)
     }
}

