# Private Events

A Ruby on Rails event pplanner and management app inspired by Eventbrite. This project is a part of The Odin Project Ruby path curriculum to practice ActiveRecord associations. 

## Full project outline, its core and extra features, challenges and bugs occured during the testing phase will be explained here:

## About the project:

Users  can:
- create events
- attend events
- manage attendance requests(edit and delete the event as a creator)
- accept or decline attendees(as an attendee)
- view upcoming and past events


---

## Features

### Authentication
- User registration and login with Devise
- Protected routes for authenticated users

### Event Management
- Create, edit and delete events (extra feature added)
- View upcoming and past events
- Event ownership authorization 

### Attendance System
- Request attendance to events
- Accept or decline attendance requests
- Cancel attendance
- Prevent duplicate attendance requests (added later during the testing phase)
- Attendance status tracking:
  - pending
  - accepted
  - declined

### User Dashboard
- Created events
  Pending requests
- Upcoming attended events
- Declined requests
- Past attended events

---

## Tech Stack

- Ruby on Rails
- SQLite3
- Devise
- ERB
- RESTful routing
- ActiveRecord associations

---

## Database Associations

### User
- has_many :created_events
- has_many :attendances
- has_many :attended_events

### Event
- belongs_to :creator
- has_many :attendances
- has_many :attendees

### Attendance
- belongs_to :attendee
- belongs_to :event

---

## Major Challenges & Bugs Fixed

### 1. Devise Infinite Redirect Loop

One of the most difficult bugs occurred after authentication setup.

Problem:
- `/users/sign_in` redirected infinitely
- Safari displayed:
  "Too many redirects occurred"

Cause:
- `resources :users` route was placed before `devise_for :users`
- Rails thought `/users/sign_in` as `UsersController#show`

Fix:
- moved `devise_for :users` above all user routes()

lesson learned:
- Rails route order matters a lot
- Devise routes should usually appear before other overlapping resource routes

---

### 2. Foreign Key Bug (`attendees` table)

Problem:
```text
SQLite3::SQLException:
no such table: main.attendees
```

Cause:
- defective schema state showed:
```ruby
add_foreign_key "attendances", "attendees"
```

even though the model correctly pointed to user table:
```ruby
foreign_key: { to_table: :users }
```

Fix:
- removed broken `schema.rb`
- entirely rebuilt database:
```bash
rm db/schema.rb
rails db:drop db:create db:migrate
```

Lesson learned:
- `schema.rb` is a generated database snapshot
- stale schema state can keep incorrect foreign keys

---

### 3. Duplicate Attendance Requests

Problem:
- users could attend the same event several times
- dashboard displayed duplicate attendance requests

Fix:
- added uniqueness validation:
```ruby
validates :attendee_id, uniqueness: { scope: :event_id }
```

- added database unique index:
```ruby
add_index :attendances, [:attendee_id, :event_id], unique: true
```

Lesson learned:
- validations alone are not enough
- database should be in sync for data integrity


---

### 4. Missing Partial Errors

Problem:
```text
Missing partial users/_event_request
```

Cause:
- Rails partial naming convention mismatch

Fix:
- created reusable partial:
```text
app/views/users/_event_request.html.erb
```

Lesson learned:
- Rails automatically searches for partials using naming conventions

---

### 5. Nested Route Helper Errors

Problem:
```text
undefined method 'attendance_path'
```

Cause:
- attendances were nested under events

Fix:
```erb
event_attendance_path(event, attendance)
```

Lesson learned:
- nested resources generate nested route helpers

These are only significant errors ecnountered during the testing phase. There were many other tiny bugs that were not included in the readme file. 


---

## Future Improvements

- Event search/filtering
- Real-time notifications
- Responsive mobile UI
- Event categories/tags

---

## Installation

```bash
git clone <repo-url>
cd private-events
bundle install
rails db:create
rails db:migrate
bin/dev
```

---


## Author

Built by Zara