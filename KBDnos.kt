import isel.leic.utils.Time

const val DVALMASK = 0x10
const val KACK_MASK = 0X80
const val NONE = 0;
const val SMASK = 0x0F
val teclado = charArrayOf(
    '1', '4', '7', '*',
    '2', '5', '8', '0',
    '3', '6', '9', '#',
)

object KBD {
    var keypress = false

    fun init() {
        keypress = HAL.isBit(DVALMASK)
    }

    fun getKey(): Char {
        if (HAL.isBit(DVALMASK)) {
            HAL.setBits(KACK_MASK)
            HAL.clrBits(KACK_MASK)
            return teclado[HAL.readBits(SMASK)]
        }
        return NONE.toChar()
    }

    fun waitKey(timeout: Long): Char {
        val time = Time.getTimeInMillis()
        while (Time.getTimeInMillis() - time < timeout) {
            val key = getKey()
            if(key != NONE.toChar()) return key
        }
        return NONE.toChar()
    }
}

/*fun main(){
    HAL.init()
    KBD.init()
    println(KBD.waitKey(5000))
    println(KBD.waitKey(16000))
    println(KBD.waitKey(3000))
    println(KBD.waitKey(10000))
    println(KBD.waitKey(1000))
    while (true){
        val k = KBD.getKey()
        if( k != KBD.NONE.toChar()) print(k)
    }
}*/
