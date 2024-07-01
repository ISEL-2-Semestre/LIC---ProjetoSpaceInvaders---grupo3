object Scores {

    private val fileName = "SIG_scores.txt"

    fun writeScore(score: Int, player: String) {
        val formatoScore = "$score;$player\n"
        FileAccess.appendToFile(fileName, formatoScore)
    }
}

fun main() {
    // Example scores
    Scores.writeScore(107, "Joe Biden")
    Scores.writeScore(49, "Ninja")
}
