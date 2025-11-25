//
//  QuizService.swift
//  VisionPro3DExplorer
//
//  Created by Eduardo Garcia Fensterseifer on 18/11/25.
//


import CloudKit
import Foundation

class QuizService {
    
    var database: [(question: Question, answers: [Answer])]

    init() {
        self.database = [
            (
                question: Question(id: 1, text: "Qual é a melhor descrição de uma constante em Swift?"),
                answers: [
                    Answer(id: 1, text: "Um valor que pode ser alterado após a atribuição inicial usando var", isCorrect: false, question: 1),
                    Answer(id: 2, text: "Um valor que não pode ser alterado após a atribuição inicial usando let", isCorrect: true, question: 1),
                    Answer(id: 3, text: "Uma referência fraca que pode tornar-se nil automaticamente", isCorrect: false, question: 1),
                    Answer(id: 4, text: "Um tipo especial usado apenas dentro de classes", isCorrect: false, question: 1)
                ]
            ),
            
            (
                question: Question(id: 2, text: "O que este código imprime? let a = 3; let b = 2; print(a + b * 2)"),
                answers: [
                    Answer(id: 6, text: "10", isCorrect: false, question: 2),
                    Answer(id: 7, text: "7", isCorrect: true, question: 2),
                    Answer(id: 8, text: "8", isCorrect: false, question: 2),
                    Answer(id: 9, text: "12", isCorrect: false, question: 2)
                ]
            ),
            
            (
                question: Question(id: 3, text: "Qual é a maneira idiomática de declarar uma função que retorna uma string de boas-vindas com um nome?"),
                answers: [
                    Answer(id: 11, text: "func hello(name: String) -> String  'Ola, name'", isCorrect: false, question: 3),
                    Answer(id: 12, text: "func hello(name: String) -> String { return \"Ola, name\" }", isCorrect: true, question: 3),
                    Answer(id: 13, text: "func hello(String) -> String  return 'Ola'", isCorrect: false, question: 3),
                    Answer(id: 14, text: "func hello(name: String) -> String  return 'Ola, name'", isCorrect: false, question: 3)
                ]
            ),
            
            (
                question: Question(id: 4, text: "Como você torna um parâmetro de função opcional em Swift e usa valor padrão?"),
                answers: [
                    Answer(id: 16, text: "Declarando com String? e atribuindo nil como padrão", isCorrect: true, question: 4),
                    Answer(id: 17, text: "Usando inout no parâmetro", isCorrect: false, question: 4),
                    Answer(id: 18, text: "Colocando um ponto de interrogação após o nome da função", isCorrect: false, question: 4),
                    Answer(id: 19, text: "Declarando o parâmetro como Optional<String> sem valor padrão", isCorrect: false, question: 4),
                ]
            ),
            
            (
                question: Question(id: 5, text: "Qual é a finalidade principal de usar guard let ao trabalhar com opcionais?"),
                answers: [
                    Answer(id: 21, text: "Executar sempre o bloco else, independentemente do valor", isCorrect: false, question: 5),
                    Answer(id: 22, text: "Desembrulhar condicionalmente um opcional e sair cedo em caso de falha", isCorrect: true, question: 5),
                    Answer(id: 23, text: "Converter qualquer tipo em String automaticamente", isCorrect: false, question: 5),
                    Answer(id: 24, text: "Evitar a necessidade de usar if em qualquer situação", isCorrect: false, question: 5)
                ]
            )
        ]
    }
}

