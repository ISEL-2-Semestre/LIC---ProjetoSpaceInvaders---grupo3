object SerialEmitter { // Envia tramas para os diferentes módulos Serial Receiver.
    private val LCDset_MASK = 0x01
    private val SCSET_MASK = 0x02
    private val SDX_MASK = 0x08
    private val SCLK_MASK = 0x10

    enum class Destination {LCD, SCORE}

    // Inicia a classe
    fun init() {
        HAL.init()
        HAL.setBits(LCDset_MASK)
        HAL.setBits(SCSET_MASK)
    }

    // Envia uma trama para o SerialReceiver identificado o destino em addr,os bits de dados em
    //  ‘data’ e em size o número de bits a enviar.
    fun send(addr: Destination, data: Int, size: Int) {

        var notSS_MASK = 0
        notSS_MASK = if(addr == Destination.LCD){
            LCDset_MASK
        } else{
            SCSET_MASK
        }

        HAL.clrBits(notSS_MASK)
        var ctr = 0
        for (i in 0..size-1) {
            val bitIn = data.and(1.shl(i))
            if (bitIn == 0) {
                HAL.clrBits(SDX_MASK)
            } else {
                HAL.setBits(SDX_MASK)
                ctr++
            }
            HAL.setBits(SCLK_MASK)
            HAL.clrBits(SCLK_MASK)
        }
        if (ctr % 2 == 0) {
            HAL.clrBits(SDX_MASK)
        } else {
            HAL.setBits(SDX_MASK)
        }
        HAL.setBits(SCLK_MASK)
        HAL.clrBits(SCLK_MASK)
        HAL.setBits(notSS_MASK)
    }
}




fun main(){
    SerialEmitter.init()
    //SerialEmitter.send(SerialEmitter.Destination.LCD,0b011011011,9)
    //LCD.writeCMD(0x30)
    SerialEmitter.send(SerialEmitter.Destination.SCORE,0x0D,7)
}
