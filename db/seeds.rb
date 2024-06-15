# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb


# Create Users
users = [
  { email: 'student1@example.com', password: 'password', role: 0, registration_key: 'kHumhuHkyyvs8ikZV_BJWfKPQzUoyHu!hukC@JYDpobqzaJBbw' },
  { email: 'student2@example.com', password: 'password', role: 0, registration_key: 'kHumhuHkyyvs8ikZV_BJWfKPQzUoyHu!hukC@JYDpobqzaJBbw' },
  { email: 'teacher@example.com', password: 'password', role: 1, registration_key: 'AmYytGVoPMzzy8gXQL4qMw!_b_6QTG-WmaaddyhQ2d9Usm@mba' }
]

users.each do |user_attrs|
  User.create!(user_attrs)
end

# Create Scenarios
scenarios = [
  { name: 'Evaluating News Sources', description: 'Students evaluate the reliability of various news sources.' },
  { name: 'Assessing Social Media Posts', description: 'Students assess the credibility of information shared on social media.' }
]

scenarios.each do |scenario_attrs|
  Scenario.create!(scenario_attrs)
end

# Create Tasks
tasks = [
  { name: 'Identify Reliable Sources', description: 'Identify which of the following news sources are considered reliable.', scenario_id: Scenario.find_by(name: 'Evaluating News Sources').id },
  { name: 'Spot Fake News', description: 'Analyze the given posts and determine which ones are spreading fake news.', scenario_id: Scenario.find_by(name: 'Assessing Social Media Posts').id },
  { name: 'Analyze News Headlines', description: 'Analyze the given news headlines and determine which ones are misleading.', scenario_id: Scenario.find_by(name: 'Evaluating News Sources').id }
]

tasks.each do |task_attrs|
  Task.create!(task_attrs)
end

# Create Evaluations
evaluations = [
  {
    accuracy: 5, accuracy_description: 'Highly accurate analysis with all criteria met perfectly.', relevance: 5, relevance_description: 'The evaluation is highly relevant and directly addresses the task requirements.',
    bias: 1, bias_description: 'Minimal bias detected. The student provided an objective and fair analysis.', comments: 'Well done. The evaluation is thorough and insightful.', 
    task: Task.find_by(name: 'Identify Reliable Sources'), 
    user: User.find_by(email: 'student1@example.com')
  },
  {
    accuracy: 3, accuracy_description: 'Moderately accurate with some errors in judgment.', relevance: 4, relevance_description: 'Relevant but could have been more specific to the task at hand.',
    bias: 3, bias_description: 'Noticeable bias in some parts of the evaluation. Needs to be more objective.', comments: 'Needs improvement. The evaluation lacks depth in certain areas.', 
    task: Task.find_by(name: 'Spot Fake News'), 
    user: User.find_by(email: 'student2@example.com')
  },
  {
    accuracy: 4, accuracy_description: 'Mostly accurate with a few minor errors.', relevance: 5, relevance_description: 'Highly relevant and directly addresses the task requirements.',
    bias: 2, bias_description: 'Some bias detected. The student needs to be more objective in their analysis.', comments: 'Good job. The evaluation is well-structured and insightful.',
    task: Task.find_by(name: 'Identify Reliable Sources'),
    user: User.find_by(email: 'student1@example.com')
  },
  {
    accuracy: 2, accuracy_description: 'Inaccurate analysis with several errors in judgment.', relevance: 3, relevance_description: 'Somewhat relevant but lacks specificity to the task at hand.',
    bias: 4, bias_description: 'Strong bias detected throughout the evaluation. Needs to be more objective.', comments: 'Needs significant improvement. The evaluation is biased and lacks depth.',
    task: Task.find_by(name: 'Spot Fake News'),
    user: User.find_by(email: 'student2@example.com')
  },
  {
    accuracy: 5, accuracy_description: 'Highly accurate analysis with all criteria met perfectly.', relevance: 5, relevance_description: 'The evaluation is highly relevant and directly addresses the task requirements.',
    bias: 1, bias_description: 'Minimal bias detected. The student provided an objective and fair analysis.', comments: 'Excellent work. The evaluation is thorough and insightful.',
    task: Task.find_by(name: 'Analyze News Headlines'),
    user: User.find_by(email: 'student1@example.com')
  },
]

evaluations.each do |evaluation_attrs|
  Evaluation.create!(evaluation_attrs)
end

puts 'Seed data loaded successfully!'