object ScoreDisplay { // Controla o mostrador de pontuação.
    // Inicia a classe, estabelecendo os valores iniciais.
    fun init(){
    SerialEmitter.init()
    }
    // Envia comando para atualizar o valor do mostrador de pontuação
    fun setScore(value: Int){
      val valor = value.toString().reversed()
    for(i in 0..valor.length-1){
        val data = i + valor[i].code.shl(3)
       SerialEmitter.send(SerialEmitter.Destination.SCORE,data,7)
    }
        SerialEmitter.send(SerialEmitter.Destination.SCORE,0x06,7)
    }
    // Envia comando para desativar/ativar a visualização do mostrador de pontuação
    fun off(value: Boolean){
        if(value){SerialEmitter.send(SerialEmitter.Destination.SCORE,0x0F,7)}
        else{SerialEmitter.send(SerialEmitter.Destination.SCORE,0x07,7)}
    }
}

fun main(){
    ScoreDisplay.init()
    ScoreDisplay.off(false)
    ScoreDisplay.setScore(694200)

}
