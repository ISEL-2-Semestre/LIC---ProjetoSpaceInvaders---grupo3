import isel.leic.utils.Time

const val HOUR= 3600000L
const val UP = 0
const val DOWN = 1
fun TUI() {
    KBD.init()
    LCD.init()
    SerialEmitter.init()
    ScoreDisplay.init()
    ScoreDisplay.off(false)

    var cursor = UP
    var key = ' '
    val invaders = mutableListOf<Char>()
    var score = 0
    var count = 0

    LCD.cursor(0,2)
    LCD.write("Space Invaders")
    LCD.cursor(1,10)
    LCD.write("Grupo3")

    val startup = KBD.waitKey(HOUR)

    if (startup == '*'){
        LCD.clear()
        LCD.cursor(cursor,0)
        LCD.write("}")
        while(true){
            Time.sleep(500)
            ScoreDisplay.setScore(score)
            val input = KBD.getKey()

            when (input){
                in '0'..'9' -> {
                    key = input
                    LCD.cursor(cursor,0)
                    LCD.write(key)
                }
                '*' ->{
                    LCD.cursor(cursor,0)
                    LCD.write("  ")
                    if (cursor == UP) cursor = DOWN
                    if (cursor == DOWN) cursor = UP
                    LCD.cursor(cursor,0)

                }
            }

        }
    }
}

fun main(){TUI()}
