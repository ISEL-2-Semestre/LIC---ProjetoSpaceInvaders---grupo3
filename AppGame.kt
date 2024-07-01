import isel.leic.utils.Time
import kotlin.system.exitProcess
const val MAX_COLUMN = 16
const val NAME_SIZE = 13
const val CURSOR_START = 5
fun createInvaders(invaders: MutableList<Char>, lin: Int) {
    val randomInvader = intArrayOf(1, 2, 3, 4, 5, 6, 7, 8, 9).random().toString()
    invaders.add((randomInvader[0]))
    refreshInvaders(invaders,lin)
}
fun refreshInvaders(invaders: MutableList<Char>, lin: Int) {
    clrInvaders(lin)
    for (i in 0..<invaders.size) {
        val pos = 16 - invaders.size + i
        LCD.cursor(lin, pos)
        LCD.write(invaders[i])
    }
}
private fun clrInvaders(lin: Int){
    for (i in 3 ..15) {
        LCD.cursor(lin, i)
        LCD.write(' ')
    }
}
fun APP() {
    var coin = 0
    var games = 0
    var M = Maintenance.readM()
    while (true) {
        while(M) {
            M = Maintenance.readM()
            Time.sleep(80)
            if(!M) break
            LCD.clear()
            LCD.cursor(0, 1)
            LCD.write("On Maintenance")
            LCD.cursor(1, 0)
            LCD.write("*-Count #-shutD")
            val keyValue = KBD.waitKey(200)
            when (keyValue) {
                '*' -> {
                    LCD.clear()
                    LCD.cursor(0, 0)
                    LCD.write("Games:$games")
                    LCD.cursor(1, 0)
                    LCD.write("Coins:$coin")
                    val keyValueNext = KBD.waitKey(1500)
                    if (keyValueNext == '#') {
                        LCD.clear()
                        LCD.cursor(0, 1)
                        LCD.write("Clear counters")
                        LCD.cursor(1, 0)
                        LCD.write("5-Yes")
                        LCD.cursor(1, 7)
                        LCD.write("other-No")
                        val key = KBD.waitKey(1500)
                        if (key == '5') {
                            coin = 0
                            games = 0
                            FileAccess().clearFile("statistics.txt")
                            Statistics().totalGamesAndCoins(games,coin/2)
                        }
                    }
                }
                '#' -> {
                    LCD.clear()
                    LCD.cursor(0, 4)
                    LCD.write("Shutdown")
                    LCD.cursor(1, 0)
                    LCD.write("5-Yes")
                    LCD.cursor(1, 7)
                    LCD.write("other-No")
                    val keyValueNext = KBD.waitKey(1500)
                    if (keyValueNext == '5') {
                        exitProcess(1)
                    }
                }
                '0' -> {
                    val line = 0
                    val score = 0
                    LCD.clear()
                    LCD.cursor(0, 0)
                    LCD.write("]")
                    LCD.cursor(1, 0)
                    LCD.write("]")
                    LCD.cursor(line, 1)
                    LCD.write("}")
                    shootingMode(line, score)
                }
            }
        }
        M = Maintenance.readM()
        Time.sleep(500)
        while(!M) {
            TUI.init()
            val coinString = "$coin"
            LCD.cursor(1, MAX_COLUMN - coinString.length - 1)
            LCD.write('$')
            LCD.cursor(1, MAX_COLUMN - coinString.length)
            LCD.write(coinString)
            var line = 0
            //var key = ' '
            //val invadersLine1 = mutableListOf<Char>()
            //val invadersLine2 = mutableListOf<Char>()
            var score = 0
            //var counter = 0
            M = Maintenance.readM()
            Time.sleep(80)
            if(M) break
            while (true) {
                M = Maintenance.readM()
                Time.sleep(80)
                if(M) break
                val coin_acceptor = CoinAcceptor.acceptCoin()
                Time.sleep(80)
                if (coin_acceptor) {
                    coin += 2
                    val coinString = "$coin"
                    LCD.cursor(1, MAX_COLUMN - coinString.length - 1)
                    LCD.write('$')
                    LCD.cursor(1, MAX_COLUMN - coinString.length)
                    LCD.write(coinString)
                }
                if (coin > 0) {
                    val startupKEY = KBD.getKey()
                    if (startupKEY == '*') {
                        ScoreDisplay.off(true)
                        LCD.clear()
                        LCD.cursor(0, 0)
                        LCD.write("]")
                        LCD.cursor(1, 0)
                        LCD.write("]")
                        LCD.cursor(line, 1)
                        LCD.write("}")
                        break
                    }
                }
            }
            Time.sleep(80)
            M = Maintenance.readM()
            if (!M) {
                score = shootingMode(line, score)
            }
            Time.sleep(80)
            if(M) break
            Time.sleep(80)
            val values = putNames(coin, score)
            coin = values.first
            val name = values.second
            Scores().writeScore(score, name)
            val scores = Statistics().getScores("SIG_scores")
            val orderedScores = Statistics().orderAndLimitScores(scores,20)
            FileAccess().clearFile("SIG_scores")
            orderedScores.forEach {
                Scores().writeScore(it.score,it.name)
            }
            games++
            FileAccess().clearFile("statistics.txt")
            Statistics().totalGamesAndCoins(games,coin/2)
        }
    }
}
fun shootingMode(l: Int, s: Int): Int  {
    var line = l
    var key = ' '
    val invadersLine1 = mutableListOf<Char>()
    val invadersLine2 = mutableListOf<Char>()
    var score = s
    var counter = 0
    while (true) {
        ScoreDisplay.setScore(score)
        val time = when (score) {
            in 0..49 -> 230L
            in 50..99 -> 200L
            in 100..200 -> 180L
            else -> 150L
        }
        val keyValue = KBD.waitKey(20)
        when (keyValue) {
            in '0'..'9' -> {
                key = keyValue
                LCD.cursor(line, 0)
                LCD.write(key)
            }
            '*' -> {
                LCD.cursor(line, 0)
                LCD.write(']')
                LCD.cursor(line, 1)
                LCD.write(' ')
                line = if (line == 0) 1 else 0
                LCD.cursor(line, 1)
                LCD.write('}')
                key = ' '
            }
            '#' -> {
                if (line == 0) {
                    if (invadersLine1.size > 0 && invadersLine1[0] == key) {
                        LCD.cursor(line, MAX_COLUMN - invadersLine1.size)
                        val invaderValue1 = invadersLine1[0].toString().toInt()
                        invadersLine1.removeAt(0)
                        LCD.write(' ')
                        LCD.cursor(line, 0)
                        LCD.write(']')
                        refreshInvaders(invadersLine1, 0)
                        score += invaderValue1 + 1
                    }
                } else {
                    if (invadersLine2.size > 0 && invadersLine2[0] == key) {
                        LCD.cursor(line, MAX_COLUMN - invadersLine2.size)
                        val invaderValue2 = invadersLine2[0].toString().toInt()
                        invadersLine2.removeAt(0)
                        LCD.write(' ')
                        LCD.cursor(line, 0)
                        LCD.write(']')
                        refreshInvaders(invadersLine2, 1)
                        score += invaderValue2 + 1
                    }
                }
                key = ' '
            }
        }
        counter++
        if (counter == 4) {
            val invaderLine = intArrayOf(1, 2).random()
            if (invadersLine1.size >= 14 || invadersLine2.size >= 14) {
                Time.sleep(300)
                LCD.clear()
                LCD.cursor(0, 0)
                LCD.write("*** Game Over **")
                LCD.cursor(1, 0)
                LCD.write("Score: $score")
                Time.sleep(3000)
                break
            }
            if (invaderLine == 1) {
                createInvaders(invadersLine1, 0)
            } else {
                createInvaders(invadersLine2, 1)
            }
            counter = 0
        }
    }
    return score
}
fun putNames(c: Int, score: Int): Pair<Int, String> {
    val letters = ('A'..'Z').toList().toCharArray()
    var letterPos = 0
    var cursorPos = CURSOR_START
    var coin = c
    LCD.clear()
    LCD.cursor(1, 0)
    LCD.write("Score:$score")
    LCD.cursor(0, 0)
    LCD.write("Name:")
    LCD.cursor(0, cursorPos)
    LCD.write(letters[letterPos])
    val name = charArrayOf(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ')
    val name = charArrayOf('A', ' ', ' ', ' ', ' ', ' ', ' ', ' ')

    while (true) {
        val key = KBD.getKey()
        when (key) {
            '2' -> {
                LCD.cursor(0, cursorPos)
                if (letterPos == letters.lastIndex) {
                    letterPos = letters.lastIndex
                } else {
                    letterPos++
                }
                LCD.write(letters[letterPos])
                name[cursorPos - CURSOR_START] = letters[letterPos]
            }
            '4' -> {
                if (cursorPos <= CURSOR_START) {
                    cursorPos = CURSOR_START
                } else {
                    cursorPos--
                    LCD.cursor(0, cursorPos)
                    val letterPosNow = TUI.findLetterPos(letters, name[cursorPos - CURSOR_START])
                    letterPos = letterPosNow
                }
            }
            '5' -> {
                coin--
                LCD.clear()
                Time.sleep(100)
                break
            }
            '6' -> {
                if (cursorPos < NAME_SIZE - 1) {
                    cursorPos++
                } else {
                    cursorPos = NAME_SIZE - 1
                }
                LCD.cursor(0, cursorPos)
                val letterPosNow = TUI.findLetterPos(letters, name[cursorPos - CURSOR_START])
                letterPos = letterPosNow
                LCD.write(letters[letterPos])
                name[cursorPos-CURSOR_START] = letters[letterPos]
            }
            '8' -> {
                LCD.cursor(0, cursorPos)
                if (letterPos > 0) {
                    letterPos--
                } else {
                    letterPos = 0
                }
                LCD.write(letters[letterPos])
                name[cursorPos - CURSOR_START] = letters[letterPos]
            }
        }
    }
    val n = name.joinToString(separator = "").trim()
    return Pair(coin, n)
}
fun main(){
    APP()
}
