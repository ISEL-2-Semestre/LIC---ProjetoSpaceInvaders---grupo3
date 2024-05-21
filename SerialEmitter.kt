import isel.leic.UsbPort
object SerialEmitter {
    // Envia tramas para os diferentes módulos Serial Receiver.
    private val LCDset_MASK = 0x01
    private val SCLK_MASK = 0x02
    private val SDX_MASK = 0x04

    enum class Destination {LCD, SCORE}
    // Inicia a classe
    fun init(){
        HAL.init()
        HAL.setBits(LCDset_MASK)
        HAL.setBits(SCLK_MASK)

    }
    // Envia uma trama para o SerialReceiver identificado o destino em addr,os bits de dados em
    // ‘data’ e em size o número de bits a enviar.
    fun send(addr: Destination, data: Int, size: Int) {

        var NOTSS_MASK = 0
        if(addr == Destination.LCD){NOTSS_MASK = LCDset_MASK}
        else{NOTSS_MASK = SCLK_MASK}

        HAL.clrBits(NOTSS_MASK)
        var counter = 0
        for (i in 0..size-1) {

            val bit = data.and(1.shl(i))
            if (bit == 0) {
                HAL.clrBits(SDX_MASK)
            } else {
                HAL.setBits(SDX_MASK)
                counter++
            }
            HAL.setBits(SCLK_MASK)
            HAL.clrBits(SCLK_MASK)
        }
        if (counter % 2 == 0) {
            HAL.clrBits(SDX_MASK)
        } else {
            HAL.setBits(SDX_MASK)
        }
        HAL.setBits(SCLK_MASK)
        HAL.clrBits(SCLK_MASK)
        HAL.setBits(NOTSS_MASK)
    }
}

fun main() {
    SerialEmitter.init()
    SerialEmitter.send(SerialEmitter.Destination.LCD,0b111111111,9)
}


