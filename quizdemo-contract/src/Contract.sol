// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract QuestionContract {
    struct Quiz {
        string question;
        string[] options;
        uint256 correctAnswerIndex;
    }

    Quiz public quiz;
    mapping(address => bool) public hasAnswered;
    mapping(address => bool) public isCorrect;

    constructor(string memory _question, string[] memory _options, uint256 _correctAnswerIndex) {
        require(_options.length >= 2, "Must have at least 2 options");
        require(_correctAnswerIndex < _options.length, "Correct answer index must be less than the number of options");
        quiz = Quiz({
            question: _question,
            options: _options,
            correctAnswerIndex: _correctAnswerIndex
        });
    }

    function answerQuestion(uint256 _answerIndex) public {
        require(!hasAnswered[msg.sender], "You have already answered the question");
        require(_answerIndex < quiz.options.length, "Answer index must be less than the number of options");

        hasAnswered[msg.sender] = true;
        if (_answerIndex == quiz.correctAnswerIndex) {
            isCorrect[msg.sender] = true;
        }
    }

    function getQuiz() public view returns (string memory, string[] memory) {
        return (quiz.question, quiz.options);
    }

    function checkAnswer() public view returns (bool) {
        require(hasAnswered[msg.sender], "You have not answered the question");
        return isCorrect[msg.sender];
    }
}