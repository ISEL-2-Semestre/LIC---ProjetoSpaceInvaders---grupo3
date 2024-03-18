import isel.leic.UsbPort
import isel.leic.utils.Time

const val DVAL_MASK = 0x10
const val smask = 0xF
val outputd = HAL.readBits(DVAL_MASK)
val output = HAL

object KBD { // Ler teclas. Métodos retornam ‘0’..’9’,’#’,’*’ ou NONE.

    const val NONE = '0';
    var output = 0
    // Inicia a classe
    fun init(){
        UsbPort.write(output)
    }
// Retorna de imediato a tecla premida ou NONE se não há tecla premida.
    fun getKey(): Char {

    }
// Retorna a tecla premida, caso ocorra antes do ‘timeout’ (representado em milissegundos), ou
    fun waitKey(timeout: Long): Char{
        return if (timeout - Time.getTimeInMillis() >=0 && HAL.isBit(DVAL_MASK)){
            getKey()
        }
        else NONE
    }
}