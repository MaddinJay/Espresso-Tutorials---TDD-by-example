# TDD by example

For links and slides, see: https://miro.com/app/board/uXjVNLJPRew=/

This repository was created for the Espresso Tutorials course "TDD by example." Link to the course: TBD

## Introductory Example in TDD - Code Kata FizzBuzz

As an introductory example, we have chosen the Code Kata FizzBuzz (https://codingdojo.org/kata/FizzBuzz/). The TDD cycle is illustrated through the Code Kata, where we collectively develop the core solution for the "convert_number" method. The commit history demonstrates the steps taken to derive the solution for the main "convert" method.

The "final" class ycl_fizz_buzz can be integrated into a report, although this is not illustrated here.

## Practical Example in TDD - Calculate Average Rating
Based on the data model from the "ABAP Steam Punk" course by Prof. Dr. Christian Drumm, we go through the TDD cycle. In the first step, we develop the "core algorithm" for calculating the Average Ratings (method calculate_avg_rating) to demonstrate how a solution can be worked out in small steps in a real-world example.

Next, we introduce the Dependency Injection Principle (DIP) and the SAP Test Double Framework for the implementation of the DB select. For displaying the data, we also use DIP, but for mocking, we employ "local test doubles." To enhance organization, we apply the "Integration Operation Segregation Principle." Finally, with the "Local Friends Principle," we can hide our "core algorithm" method externally and still make it accessible to our test class.

The implementation of the "show_in_alv" method in the ycl_print_data class is omitted in this repository. Additionally, the domain class is not integrated into a report, even though it was designed to be. These steps are left to the reader.
