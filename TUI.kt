object TUI {
    fun init() {
        HAL.init()
        KBD.init()
        LCD.init()
        LCD.cursor(0, 1)
        LCD.write("Space Invaders")
        LCD.cursor(1, 0)
        LCD.write(" LEIC_21D_G03 ")
    }

    fun findLetterPos(a: CharArray, c: Char): Int {
        var l = 0
        var r = a.size - 1
        while (l<=r) {
            val mid = (l+r)/2
            if(a[mid]==c) return mid
            else {
                if(a[mid]<c) l = mid+1
                else r = mid-1
            }
        }
        return 0
    }
}