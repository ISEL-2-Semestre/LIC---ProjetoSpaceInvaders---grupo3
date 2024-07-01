import java.io.File
import java.io.BufferedReader
import java.io.FileReader

object FileAccess {

    data class Score(val score:Int, val name: String)

    fun writeFile(name: String, content: String) {
        val file = File(name)
        file.writeText(content)
        println("Ficheiro escrito")
    }

    fun readFile(name: String): List<Score> {
        val scores = mutableListOf<Score>()
        val reader = BufferedReader(FileReader(name))
        reader.use { r ->
            r.forEachLine { line ->
                val parts = line.split(";")
                if (parts.size == 2) {
                    val score = parts[0].toInt()
                    val name = parts[1]
                    scores.add(Score(score, name))
                }
            }
        }
        return scores
    }

    fun appendToFile(name: String, content: String) {
        val file = File(name)
        file.appendText(content)
        println("ficheiro editado.")
    }

    fun clearFile(name: String) {
        val file = File(name)
        file.writeText("") // This will overwrite the file with an empty string
        println("File cleared: $name")
    }

    fun readFileGamesAndCoins(name: String): Pair<Int, Int> {
        var coins = 0
        var games = 0
        val reader = BufferedReader(FileReader(name))
        reader.use { r ->
            val txt = r.readLines()
            games = txt[0].toInt()
            coins = txt[1].toInt() * 2
        }
        return games to coins
    }
}
