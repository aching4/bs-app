struct FriendShare: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var items: [BillItem]
    var tax: Double
    var tip: Double

    //MATH FOR JIMMY-------------------------------------------------
    var totalAmount: Double {
        let itemTotal = items.reduce(0) { $0 + $1.price }
        let totalWithTax = itemTotal + (itemTotal * tax / 100)
        let totalWithTip = totalWithTax + (totalWithTax * tip / 100)
        return totalWithTip
    }
}
    //---------------------------------------------------------------
struct BillItem {
    var itemName: String
    var price: Double
}
