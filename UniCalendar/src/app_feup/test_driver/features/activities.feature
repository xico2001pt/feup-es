Feature: Visualize activities calendar page
  As an UP member, 
  I want to see a Moodle activities calendar page, 
  so that I can keep up with their deadlines and have more functionalities.

  Scenario: Access the on going activities
    When I fill the "usernameinput" field with my usercode
    And  I fill the "passwordinput" field with my password
    And I tap the "entrar" button
    And I open the drawer
    And I tap the "key_Atividades" button
    Then I expect the activity subsection "A Decorrer" to be open
  
  Scenario: Access the upcoming activities
    When I fill the "usernameinput" field with my usercode
    And  I fill the "passwordinput" field with my password
    And I tap the "entrar" button
    And I open the drawer
    And I tap the "key_Atividades" button
    And I tap the "activities-page-tab-1" button
    Then I expect the activity subsection "Atividades Futuras" to be open