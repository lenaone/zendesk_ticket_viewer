# Ticket Viewer

## Desciption

Zendesk is a customer service tool that allows the creation and management of support tickets.
Your company needs you to build a Ticket Viewer that will:

- Connect to the Zendesk API
- Request the tickets for your account, page through tickets when more than 25 are
returned
- Display them in a list
- Display individual ticket details

## How to Set up

1. Make sure you have Ruby 2.5 installed in your machine.

2. `git clone https://github.com/lenaone/zendesk_ticket_viewer.git`

3. `bundle install`

### Running to app:

`ruby main.rb`

Open url in your browser: `http://localhost:4567`

### Running the Test:

`ruby main_test.rb`

## APPROACH

- I decide to do sinata app with ticket model containing all the logics and display tickets on the webpage.
  1. Downloaded sinata and designed a Ticket class in models folder.
  2. Get the data from API, so I use the httparty method get data.
  3. Display on the webpage. 
  4. Main page is `http://localhost:4567/tickets` therefore, genereate 25 tickets in a page.
  5. If a user would like to check individual ticket, click ticket number and go to individual ticket page.
  ```
    For example

     Number is 6, Ticket subject is "excepteur laborum ex occaecat Lorem"
  ```

    A user click number then,
     
    Move to `http://localhost:4567/tickets/6`

    ```

      Ticket ID: 6

      Subject: excepteur laborum ex occaecat Lorem

      status: open

      Back to all Tickets => go back to original page

  ```
  6. Write some happy path tests and unhappy path with minitest. For example, When API is unavailable, the user still see successful response. 


- Display all the tickets in main pages, page through tickets when more than 25.
- Display individual ticket detail as ID, subject, status.