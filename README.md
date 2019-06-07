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

2. `bundle install`

3. `git clone #{mygithub repository}`

### Running to app:

`ruby main.rb`

### Running the Test:

`ruby main_test.rb`

## APPROACH

- I tried to do user UI can be browser-based on website. So, I would like to choose sinatra.
  1. Downloaded sinata and designed a Ticket class in models folder.
  2. Get the data from API, so I use the httparty method get data.
  3. Display on the webpage. 
  4. Main page is `/localhost:4567/tickets` therefore, genereate 25 tickets in a page.
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

      Back to all Tickets => go back to original page

  ```
  6. Write it down some happy path test with minitest 

- Display all the tickets in main pages, page through tickets when more than 25.
- Display individual ticket detail as ID, script.