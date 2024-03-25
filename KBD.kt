import isel.leic.utils.Time

const val DVAL_MASK = 0x10
const val SMASK = 0x0F
val output = HAL.readBits(SMASK)
val teclado = charArrayOf('1', '4', '7', '*',
    '2', '5', '8', '0',
    '3', '6', '9', '#')

object KBD { // Ler teclas. Métodos retornam ‘0’..’9’,’#’,’*’ ou NONE.
    var keypress = false
    const val NONE = 0;
    var output = 0
    fun init() {
        keypress = HAL.isBit(DVAL_MASK)
    }

    // Retorna de imediato a tecla premida ou NONE se não há tecla premida.
    fun getKey(): Char {
        keypress = HAL.isBit(DVAL_MASK)
        if (keypress) return teclado[HAL.readBits(SMASK)]
        else return NONE.toChar()
    }

    fun waitKey(timeout: Long): Char {
        return if (timeout - Time.getTimeInMillis() >= 0 && HAL.isBit(DVAL_MASK)) {
            getKey()
        } else NONE.toChar()
    }
}

fun main() {
    HAL.init()
    KBD.init()
    println(KBD.getKey())
}
