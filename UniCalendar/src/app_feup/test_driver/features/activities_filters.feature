Feature: Filter the ongoing and future activities on the calendar by their course
    As an UP member,
    I want to be able to filter the calendar for ongoing and future activities by their course,
    so that I can easily keep track of the deadlines of a single or multiple courses.
    
    Scenario: Visualize activity filters list.
        When I fill the "usernameinput" field with my usercode
        And  I fill the "passwordinput" field with my password
        And I tap the "entrar" button
        And I open the drawer
        And I tap the "key_Atividades" button
        And I tap the "ActivitiesFiltersPopup" button
        Then I wait until the "ActivityFilterCheckboxList" is present

    Scenario: Uncheck all the activity filters and no activities are shown.
        When I fill the "usernameinput" field with my usercode
        And  I fill the "passwordinput" field with my password
        And I tap the "entrar" button
        And I open the drawer
        And I tap the "key_Atividades" button
        And I tap the "ActivitiesFiltersPopup" button
        And I wait until the "ActivityFilterCheckboxList" is present
        And I uncheck all the activity filters
        And I tap the "ActivitiesFilterConfirmButton" button
        Then I wait until the widget of type "PrimaryActivityRow" is absent within 2 seconds