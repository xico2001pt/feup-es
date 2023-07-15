Feature: Open Activities page from the application's sidebar
    As an UP member
    I want to be able to access the activities page through a link on the application sidebar
    so that I can see the complete list of activities.

    Scenario: Access the on going activities
      When I fill the "usernameinput" field with my usercode
      And  I fill the "passwordinput" field with my password
      And I tap the "entrar" button
      And I open the drawer
      And I tap the "key_Atividades" button
      Then I expect the text "Atividades" to be present