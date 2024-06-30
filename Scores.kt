class Scores {

    private val fileAccess = FileAccess()
    private val fileName = "SIG_scores"

    fun writeScore(score: Int, player: String) {
        val formatoScore = "$score;$player\n"
        fileAccess.appendToFile(fileName, formatoScore)
    }
}

fun main() {
    val scores = Scores()

    // Example scores
    scores.writeScore(107, "Joe Biden")
    scores.writeScore(49, "Ninja")
}