//
//  ViewController.swift
//  QuizApp_by_Shrey
//
//  Created by Student on 22/04/25.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    var questionList = [Question]()
    let score = Score()
    
    var previouslyUsedNumber: [Int] = []
    let numberOfQuestionPerRound = 5
    var currentQuestion: Question? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        filldata()
        displayQuestion()
    }

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var correctIncorrectMsg: UILabel!
    @IBOutlet weak var firstChoiceBtn: UIButton!
    @IBOutlet weak var secondChoiceBtn: UIButton!
    @IBOutlet weak var thirdChoiceBtn: UIButton!
    @IBOutlet weak var forthChoiceBtn: UIButton!
    @IBOutlet weak var nextQuestionBtn: UIButton!
    
    
    func filldata(){
        questionList.append(Question(questionTitle: "What is the capital of France?", answers: ["Berlin", "Madrid", "Paris", "Rome"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "What is the largest planet in our solar system?", answers: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "Who wrote 'Romeo and Juliet'?", answers: ["Charles Dickens", "William Shakespeare", "Mark Twain", "Jane Austen"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "What is the speed of light?", answers: ["300,000 km/s", "500,000 km/s", "700,000 km/s", "1,000,000 km/s"], correctAnswerIndex: 0))
        questionList.append(Question(questionTitle: "Which element is represented by the symbol 'O'?", answers: ["Oxygen", "Osmium", "Ozone", "Opium"], correctAnswerIndex: 0))
        questionList.append(Question(questionTitle: "Who painted the Mona Lisa?", answers: ["Pablo Picasso", "Vincent van Gogh", "Leonardo da Vinci", "Claude Monet"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "What is the capital of Japan?", answers: ["Seoul", "Beijing", "Tokyo", "Osaka"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "What is the largest ocean on Earth?", answers: ["Atlantic Ocean", "Indian Ocean", "Southern Ocean", "Pacific Ocean"], correctAnswerIndex: 3))
        questionList.append(Question(questionTitle: "Who was the first President of the United States?", answers: ["Abraham Lincoln", "George Washington", "Thomas Jefferson", "John Adams"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "What is the boiling point of water?", answers: ["90°C", "100°C", "110°C", "120°C"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "Which country is known as the Land of the Rising Sun?", answers: ["South Korea", "China", "Japan", "Thailand"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "What is the smallest prime number?", answers: ["1", "2", "3", "5"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "Who discovered gravity?", answers: ["Albert Einstein", "Isaac Newton", "Galileo Galilei", "Nikola Tesla"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "What is the tallest mountain in the world?", answers: ["K2", "Mount Kilimanjaro", "Mount Everest", "Mount Fuji"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "Which planet is known as the Red Planet?", answers: ["Earth", "Mars", "Venus", "Mercury"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "What is the symbol for gold in the periodic table?", answers: ["Au", "Ag", "Fe", "Cu"], correctAnswerIndex: 0))
        questionList.append(Question(questionTitle: "Which famous scientist developed the theory of relativity?", answers: ["Isaac Newton", "Albert Einstein", "Stephen Hawking", "Nikola Tesla"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "What is the capital of Australia?", answers: ["Sydney", "Melbourne", "Canberra", "Brisbane"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "What is the main ingredient in guacamole?", answers: ["Tomato", "Avocado", "Onion", "Lime"], correctAnswerIndex: 1))

    }
    
    
    
    func getRandomQuestion() -> Question {
        if previouslyUsedNumber.count == questionList.count {
                previouslyUsedNumber = []
            }
            
            var randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionList.count)
            
            // Ensure the random number hasn't been used already
            while previouslyUsedNumber.contains(randomNumber) {
                randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionList.count)
            }
            
            // Mark this question as used
            previouslyUsedNumber.append(randomNumber)
            
            return questionList[randomNumber]
    }
    
    
    
    func isGameOver() -> Bool{
        return score.numberOfQuestionAsked() >= numberOfQuestionPerRound
    }
    
    
    
    @IBAction func nextQuestionbtnClick(_ sender: Any) {
        
      
        if isGameOver() {
                displayScore()
            } else {
                // Otherwise, display the next question
                displayQuestion()
            }
    }
    
    func displayQuestion(){
        currentQuestion = getRandomQuestion()
        
        if let question = currentQuestion {
            let choice = question.getChoices()
            questionText.text = question.getQuestionTitle()
            
            firstChoiceBtn.setTitle(choice[0], for: .normal)
            secondChoiceBtn.setTitle(choice[1], for: .normal)
            thirdChoiceBtn.setTitle(choice[2], for: .normal)
            forthChoiceBtn.setTitle(choice[3], for: .normal)
            
            if(score.numberOfQuestionAsked() == numberOfQuestionPerRound - 1){
                nextQuestionBtn.setTitle("End Quiz", for: .normal)
            }else{
                nextQuestionBtn.setTitle("Next Question", for: .normal)
            }
        }
        
        firstChoiceBtn.isEnabled = true
        secondChoiceBtn.isEnabled = true
        thirdChoiceBtn.isEnabled = true
        forthChoiceBtn.isEnabled = true
        
        firstChoiceBtn.isHidden = false
        secondChoiceBtn.isHidden = false
        thirdChoiceBtn.isHidden = false
        forthChoiceBtn.isHidden = false
        
        correctIncorrectMsg.isHidden = true
        nextQuestionBtn.isEnabled = false
    }
    
    
    func displayScore(){
        questionText.text = score.getScore()  // Show the final score
            score.reset()  // Reset the score after displaying the result
            
            // Change button title to "Start Again!"
            nextQuestionBtn.setTitle("Start Again!", for: .normal)
            
            // Hide the answer buttons and message display after the quiz ends
            correctIncorrectMsg.isHidden = true
            firstChoiceBtn.isHidden = true
            secondChoiceBtn.isHidden = true
            thirdChoiceBtn.isHidden = true
            forthChoiceBtn.isHidden = true
        
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        if let question = currentQuestion, let answer = sender.titleLabel?.text {
            if (question.validateAnswer(to: answer)){
                
                score.increamentCorrectAnswers()
                correctIncorrectMsg.textColor = UIColor(red:0.15, green: 0.61, blue: 0.61, alpha: 1.0)
                correctIncorrectMsg.text = "Correct!"
                
            }else{
                score.increamentIncorrectAnswers()
                correctIncorrectMsg.textColor = UIColor(red:0.82, green: 0.40, blue: 0.26, alpha: 1.0)
                correctIncorrectMsg.text = "Sorry, that's not it."
            }
            
            firstChoiceBtn.isEnabled = false
            secondChoiceBtn.isEnabled = false
            thirdChoiceBtn.isEnabled = false
            forthChoiceBtn.isEnabled = false
            correctIncorrectMsg.isHidden = false
            nextQuestionBtn.isEnabled = true
        }
        
    }
    
  
    
    
    
    
}


