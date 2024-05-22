import isel.leic.utils.Time

fun main() {
    HAL.init()
    KBD.init()
    LCD.init()
    var line = 0

    while (true) {
        val key = KBD.waitKey(1000) // espera 1 segundo ou obtém a tecla pressionada
        when (key) {
            '0' -> { LCD.write(key) }
            '1' -> {  LCD.write(key)}
            '2' -> { LCD.write(key) }
            '3' -> {  LCD.write(key)}
            '4' -> { LCD.write(key) }
            '5' -> { LCD.write(key) }
            '6' -> {LCD.write(key)  }
            '7' -> {LCD.write(key)  }
            '8' -> { LCD.write(key) }
            '9' -> {LCD.write(key)  }
            // adicione mais casos aqui para outras teclas
            '*' -> {
                LCD.clear() // apaga o display
            }
            '#' -> {
                line = 1 - line // muda de linha
                LCD.cursor(line, 0)
            }
        }
    }
}
