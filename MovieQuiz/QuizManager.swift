//
//  QuizManager.swift
//  MovieQuiz
//
//  Created by William Tomaz on 16/06/20.
//  Copyright © 2020 William Tomaz. All rights reserved.
//

import Foundation
import UIKit

typealias Round = (quiz: Quiz, options: [QuizOption])

class QuizManager {
    let quizes: [Quiz]
    let quizOptions: [QuizOption]
    var score: Int
    var round: Round?
    
    init () {
        score = 0
        let quizesURL = Bundle.main.url(forResource: "quizes", withExtension: "json")! //url do json
        do {
            let quizesData = try Data(contentsOf: quizesURL) //criando o data
            quizes = try JSONDecoder().decode([Quiz].self, from: quizesData) //decodificando e jogando no array de Quizes
            let quizOptionsURL = Bundle.main.url(forResource: "options", withExtension: "json")! //url do json
            let quizOptionsData = try! Data(contentsOf: quizOptionsURL) //Criando data de quizesOptions
            quizOptions = try! JSONDecoder().decode([QuizOption].self, from: quizOptionsData) //decodificando e jogando no array de QuizesOptions
        } catch { //caso der erro em algum dos processos acima, executa esse trecho
            print(error.localizedDescription)
            quizes = []
            quizOptions = []
        }
    }
    
    func generateRandomQuiz() -> Round {
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count))) //gera um numero aleatorio de zero ate count de quizes
        let quiz = quizes[quizIndex]
        var indexes: Set<Int> = [quizIndex] //colecao nao ordenada de itens do mesmo tipo
        while indexes.count < 4 { //quando a contagem or 4 ele para de criar
            let index = Int(arc4random_uniform(UInt32(quizes.count)))
            indexes.insert(index)
        }
        let options = indexes.map({quizOptions[$0]}) //pega cada elemento e aplica uma logica// recupera o array de QuizOptions representa os elementos do indice, oq era o set de inteiros, virou um array de opcoes
        round = (quiz, options)
        return round!
    }
    
    func checkAnswer(_ answer: String) {
        guard let round = round else {return}
        if answer == round.quiz.name { //se a escolha for igual ao nome do quiz, adiciona um ponto no score
            score += 1
        }
    }
}

struct Quiz: Codable {
    let name: String
    let number: Int
}

struct QuizOption: Codable {
    let name: String
}

