object Statistics {
    fun getScores(name: String):List<FileAccess.Score>{
        val scores = FileAccess.readFile(name)
        return scores
    }
    fun orderAndLimitScores(scores: List<FileAccess.Score>, limit: Int): List<FileAccess.Score> {
        return scores.sortedByDescending { it.score }.take(limit)
    }

    fun totalGamesAndCoins(games:Int, coins:Int) {
        FileAccess.appendToFile("statistics.txt", games.toString() + "\n")
        FileAccess.appendToFile("statistics.txt", coins.toString())
    }
}

fun main() {
    val fileName = "SIG_scores.txt"

    // Get scores from the file
    val scores = Statistics.getScores(fileName)
    println("Scores: $scores")

    // Order and limit scores
    val topScores = Statistics.orderAndLimitScores(scores, 5)
    println("Top Scores: $topScores")

}
