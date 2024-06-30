import isel.leic.utils.Time

object CoinAcceptor{
    val COIN_MASK = 0x40
    val ACCEPT_MASK = 0x40
    fun init(){
        HAL.init()
    }
    fun acceptCoin():Boolean{
        if (HAL.isBit(COIN_MASK)){
            Time.sleep(10)
            HAL.setBits(ACCEPT_MASK)
            while(HAL.isBit(COIN_MASK)){
                Time.sleep(10)
            }
            HAL.clrBits(ACCEPT_MASK)
            return true
        }
        return false
    }
}

fun main() {
    CoinAcceptor.init()
    print(CoinAcceptor.acceptCoin())
    Time.sleep(100)
}