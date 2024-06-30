import isel.leic.UsbPort
import isel.leic.utils.Time

object HAL {
    private var output = 0
    fun init() {
        writeBits(0,0)
    }
    fun readBits(mask: Int): Int =
        UsbPort.read().and(mask)

    fun isBit(mask: Int): Boolean {
        return readBits(mask) != 0
    }

    fun writeBits(mask: Int, value: Int) {
        output = (value and mask) or (output and mask.inv())
        UsbPort.write(output)
    }

    fun setBits(mask: Int) {
        writeBits(mask, 0xff)
    }

    fun clrBits(mask: Int) {
        writeBits(mask, 0)
    }
}

fun main() {
    HAL.init()
    val data = 0xFF
    var mask = 0xEF
    while (mask != 0xFF) {
        HAL.writeBits(data, mask)
        Time.sleep(500)
        mask += 1
        println(HAL.readBits(0xFF))
    }

    Time.sleep(500)
    mask = 1
    HAL.writeBits(0xFF, 0xFF)
    Time.sleep(500)
    while(true) {
        if (HAL.isBit(mask)) HAL.clrBits(mask)
        else HAL.setBits(mask)
        if (mask == 128) mask = 1
        else mask = mask shl 1
        Time.sleep(500)
    }
}