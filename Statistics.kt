import java.io.File

class Statistics {
    fun getScores(name: String):List<FileAccess.Score>{
        val scores = FileAccess().readFile(name)
        return scores
    }
    fun orderAndLimitScores(scores: List<FileAccess.Score>, limit: Int): List<FileAccess.Score> {
        return scores.sortedByDescending { it.score }.take(limit)
    }

    fun totalGamesAndCoins(games:Int, coins:Int) {
        FileAccess().appendToFile("statistics.txt", games.toString())
        FileAccess().appendToFile("statistics.txt", coins.toString())
    }
}

fun main() {
    val statistics = Statistics()
    val fileName = "SIG_scores"

    // Get scores from the file
    val scores = statistics.getScores(fileName)
    println("Scores: $scores")

    // Order and limit scores
    val topScores = statistics.orderAndLimitScores(scores, 5)
    println("Top Scores: $topScores")

}