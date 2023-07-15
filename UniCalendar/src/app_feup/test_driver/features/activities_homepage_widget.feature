Feature: Visualize the Activities calendar widget on the homescreen.
    As an UP member,
    I want to see the Activities calendar widget on the homescreen,
    so that I can quickly check if I'm keeping up with my deadlines.
    
    Scenario: Visualize Activities calendar widget on the home screen.
        When I fill the "usernameinput" field with my usercode
        And  I fill the "passwordinput" field with my password
        And I tap the "entrar" button
        And I tap the "editar" button
        And I tap the "adicionar widget" button
        And I tap the "atividades" button
        And I tap the "editar" button
        Then I wait until the widget of type "ActivityCard" is present
