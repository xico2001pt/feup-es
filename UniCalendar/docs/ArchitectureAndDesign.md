## Architecture and Design

The purpose of this section is to describe our application’s architecture. To keep our feature simple and manageable we plan to implement it using the MVC design pattern by dividing it into the following modules: calendar logic, calendar UI (subdivided into a HomePage widget UI and a page UI), a module responsible for fetching data from the google sheet and a parser to transform the fetched data into Models to be used by the controller.

## Logical Architecture

<img width="500" alt="Logical Architecture" src="../images/LogicalArchitecture.png">

- Calendar UI - Display calendar in multiple formats.
  - HomePage Widget UI - Display dashboard calendar.
  - Page UI - Display page calendar.
- Calendar Logic - Command the display of the Model given a set of parameters (e.g. filters, ongoing, past activities, etc…).
- Data Parser - Parse raw data into concrete Dart Models.
- Networking - Obtain data from the backend google sheet.
- Google Sheets API - Google sheet backend interface.

# Physical Architecture

![Physical Architecture](../images/PhysicalArchitecture.png)

- UPMember Smartphone - The UP member’s smartphone where the Uni4All application will be running on.
  - Uni4All (Flutter) - Extended mobile application developed by NIAEFEUP (with Flutter) with our feature.
- Moodle Server
  - Web Server - Required to fetch the necessary data for our feature.

# Vertical Prototype

For the vertical prototype we implemented a new view with boilerplate content that will become the Moodle Activities pages ([User story #2](https://github.com/LEIC-ES-2021-22/3LEIC03T3/issues/2)), this page is accessible through the application's sidebar.

The prototype is running on **Flutter 2.0.1**, the version used by the official [UNI app](https://github.com/NIAEFEUP/project-schrodinger).

<img width="300" alt="Sidebar" src="https://user-images.githubusercontent.com/79420500/162536824-60d1d1c1-0dbf-4f33-b6cf-0090425904fd.jpg">

<img width="300" alt="Activities Page" src="https://user-images.githubusercontent.com/79420500/162536838-872004d7-8e9c-4cbf-a021-f408ff8614eb.jpg">

