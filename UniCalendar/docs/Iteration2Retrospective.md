# Release 2

This is the iteration retrospective document regarding the release of [iteration 2](This is the release at the end of iteration 2).

What's new:

- [#1](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/1) - Finished adding Activities widget to the homescreen
- [#2](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/2) - Added core functionalities to Activities page
- [#4](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/4) - Added access to Activities page via the homescreen widget
- [#10](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/10) - Loaded real data using Google Sheet's API
- [#16](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/16) - Updated documentation (Moodle activities are no longer our project's purpose)
- [#26](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/26) - Renamed Course field in Activitity model to CourseUnit to match the app's naming conventions
- [#19](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/19) - Fixed activities page drag animation
- [#22](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/22) - Fixed hour and minute padding in PrimaryActivityWidget (e.g. 1:1 to 01:01)
- [#25](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/25) - Created acceptance test for homescreen widget visibility
- [#23](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/23) - Created acceptance test for homescreen widget click
 
## a) What went well?
The initial division of work was well thought out, we managed to conclude all the planned work with a consistent workflow. The amount of work was spread across the group evenly and organized. Every work item and user story had its own branch and corresponding pull request.

We managed to complete the testing needed for the home screen widget, loaded the app with real data with the use of Google Sheets API and updated the documentation accordingly. Furthermore we fixed some issues we encountered as we implemented the core functionalities of our project, mainly the drag animation on the Activities page and the inexistence of hour and minute padding (01:01 was appearing as 1:1).

## b) What should we do differently?
In the next iteration we should be more cautious with the deadline and maintain a consistent and uniform workflow.

## c) What still puzzles me?
The UNI code is sometimes confusing and hard to develop for. 

We need to find a way to clear data/cache before each Gherkin acceptance test.

## Project Board Screenshot

![Project Board](https://user-images.githubusercontent.com/39275267/170002060-91e7e8e2-5b3c-45fb-803f-2dbfb7d27778.png)


