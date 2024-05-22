import isel.leic.utils.Time

object LCD {
    private const val LINES = 2
    private const val COLS = 16
    private const val SERIAL_INTERFACE = false
    private const val EMASK = 0x20
    private const val RSMASK = 0x40
    private const val CLKREGMASK = 0x10
    private const val DATAMASK = 0x0F
    private fun writeByteSerial(rs: Boolean, data: Int){}

    fun writeByteParallel(rs: Boolean, data: Int) {
        if (rs) HAL.setBits(RSMASK) else HAL.clrBits(RSMASK)
        val h = data.shr(4)
        HAL.writeBits(DATAMASK, h)
        HAL.clrBits(CLKREGMASK)
        HAL.setBits(CLKREGMASK)
        HAL.writeBits(DATAMASK, data)
        HAL.setBits(EMASK)
        HAL.clrBits(CLKREGMASK)
        HAL.setBits(CLKREGMASK)
        HAL.clrBits(EMASK)
    }

    fun writeByte(rs: Boolean, data: Int) {
        if(SERIAL_INTERFACE) writeByteSerial(rs, data)
        else writeByteParallel(rs, data)
    }

    fun writeCMD(data: Int) {
        writeByte(false, data)
    }

    fun writeDATA(data: Int) {
        writeByte(true, data)
    }

    fun init() {
        Time.sleep(20)
        writeCMD(0x30)
        Time.sleep(5)
        writeCMD(0x30)
        Time.sleep(1)
        writeCMD(0x30)
        writeCMD(0x38)
        writeCMD(0x08)
        writeCMD(0x01)
        Time.sleep(2)
        writeCMD(0x06)
        writeCMD(0x0E)
    }

    fun write(c: Char) {
        print(c)
        writeDATA(c.code)
    }

    fun write(text: String) {
        for(i in text) {
            println(i)
            write(i)
        }
    }

    fun cursor(line: Int, column: Int) {
        if(column in 0 until COLS) {
            var address = column
            if(line in 0 until LINES && line==1) address += 0x40
            writeCMD(0x80 or address)
        }
    }

    fun clear() {
        writeCMD(0x01)
    }
}

fun main() {
    HAL.init()
    LCD.init()
}
