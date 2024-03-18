import isel.leic.UsbPort

object HAL {
    var output = 0
    fun init() {
        UsbPort.write(output)
    }
    fun readBits(mask: Int): Int =
        UsbPort.read().and(mask)

    fun isBit(mask: Int): Boolean {
        return if (readBits(mask) != 0) true
        else false
    }

    fun writeBits(mask: Int, value: Int) {
        clrBits(mask)
        setBits(mask)
    }

    fun setBits(mask: Int) {
        val temp =(output.or(mask))
        UsbPort.write(temp)
        output=temp
    }

    fun clrBits(mask: Int){
        val temp = (output).and((mask).xor(0xFF))
        UsbPort.write(temp)
        output=temp
    }
}

fun main() {
    HAL.init()
    HAL.setBits(0x0F)
    HAL.clrBits(0x03)
    HAL.writeBits(0x0F,0x09)
}