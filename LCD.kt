import isel.leic.utils.Time

object LCD {
    private const val SERIAL_INTERFACE = true
    private const val EMASK = 0x20
    private const val RSMASK = 0x40
    private const val CLKREGMASK = 0x10
    private const val DATAMASK = 0x0F

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

    fun writeByteSerial(rs: Boolean, data: Int){
        if (rs) {
            SerialEmitter.send(SerialEmitter.Destination.LCD,1 + data.shl(1),9)}
        else{
            SerialEmitter.send(SerialEmitter.Destination.LCD,0 + data.shl(1),9)}
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
        writeCMD(0x06)
        writeCMD(0x0E)
    }

    fun write(c: Char) = writeDATA(c.code)

    fun write(text: String) {
        for(i in 0..<text.length) {
            val char = text.get(i)
            write(char)
        }
    }

    fun cursor(line: Int, column: Int) {
        writeCMD(0x80 + column + line*0x40 )
    }

    fun clear() {
        writeCMD(0x01)
    }
}

fun main() {
    LCD.init()
    LCD.clear()
    LCD.cursor(0, 1)
    LCD.write("Hello World")
    LCD.cursor(1, 0)
    LCD.write("teste")
    Time.sleep(5000)
}
