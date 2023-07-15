Feature: Interact with the Activities calendar widget on the homescreen.
    As an UP member,
    I want to click on the homescreen activities widget,
    so that I can go to the Activities page to check the complete list of activities, filter them by date or course and export the activities calendar if I please.

    Scenario: Open Activities page from the homescreen dashboard.
        When I fill the "usernameinput" field with my usercode
        And  I fill the "passwordinput" field with my password
        And I tap the "entrar" button
        And I tap the "editar" button
        And I tap the "adicionar widget" button
        And I tap the "atividades" button
        And I tap the "editar" button
        And I wait until the widget of type "ActivityCard" is present
        And I tap the "ActivityCard" widget
        Then I expect the text "Atividades" to be present