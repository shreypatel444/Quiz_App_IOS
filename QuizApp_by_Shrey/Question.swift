//
//  Question.swift
//  QuizApp_by_Shrey
//
//  Created by Student on 22/04/25.
//

import Foundation

class Question {
    var questionTitle: String = ""
    var answers: [String] = []
    var correctAnswerIndex: Int = 0
    
    init(questionTitle: String, answers: [String], correctAnswerIndex: Int){
        self.questionTitle = questionTitle
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
    
    func validateAnswer(to givenAnswer: String) -> Bool {
        return (givenAnswer == answers[correctAnswerIndex])
    }
    
    func getQuestionTitle() -> String {
        return questionTitle
    }
    
    func getAnswer() -> [String]{
        return answers
    }
    
    func getChoices() -> [String] {
        return answers
    }
 
    func getAnswerAt(index: Int) -> String {
        return answers[index]
    }
    
}


class Score {
    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    var questionPerRound = 5
    
    func reset(){
        correctAnswers = 0
        incorrectAnswers = 0
    }
    
    func increamentCorrectAnswers(){
        correctAnswers += 1
    }
    
    func increamentIncorrectAnswers(){
        incorrectAnswers += 1
    }
    
    func numberOfQuestionAsked() -> Int {
        return correctAnswers + incorrectAnswers
    }
    
    func getScore() -> String {
        if (correctAnswers == 5) {
            return "🥇 You are a genius\n\n Your score \(correctAnswers) out of \(questionPerRound)"
        }else if(correctAnswers == 4) {
            return "🥈 Excellent Work!\n\n Your score \(correctAnswers) out of \(questionPerRound)"
        }else if(correctAnswers == 3) {
            return "🥉 Good Job!\n\n Your score \(correctAnswers) out of \(questionPerRound)"
        }else{
            return "👍 Improve your score!\n\n Your score \(correctAnswers) out of \(questionPerRound)"
        }
    }  
}
