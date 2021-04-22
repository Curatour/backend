<img src="https://user-images.githubusercontent.com/69478485/115476368-f5a61700-a1fe-11eb-8d4a-8d5f7bdfd102.png" alt="CuraTour Logo" width="350" />

CuraTour is an organizational scheduling app designed for Tour Managers of traveling entertainers. It is designed to work across device types and sizes for ease of use throughout a busy day, and includes functionality while in offline modes. Each user belongs to an organization, every organization can manage multiple tours. Within each tour, events are scheduled. These events may be concerts, press events, interviews, travel days, anything relevant for the tour. Each event can have an agenda for the day - a schedule for various parts of the day (load-in, sound check, doors-open, meet and greet, etc). Users can also manage pertinent contacts through the app, and use the app to connect directly to their contacts. CuraTour is here to make your life easier, and to help the show go on.

# Curatour Backend — GraphQL API

## Getting Started

Curatour's backend API is built with [GraphQL Ruby](https://graphql-ruby.org/).

If you're new to GraphQL, a good starting point is the GraphQL Intro at [graphql.org](https://graphql.org/learn/). Once you have a basic understanding of GraphQL query and mutation syntax, using Curatour's GraphQL interface outlined below will be straightforward!

## Data Model and ERD

This entity relationship diagram (ERD) shows the setup of the PostgreSQL database being used by the Curatour backend.

![entity relationship diagram](/public/curatour_erd.png)

## Types

Each GraphQL Type represents the models and their respective attributes available for querying and mutating.

All GraphQL requests are sent via `POST` HTTP request to the `https://curatour-be.herokuapp.com/graphql` endpoint. 

The following Types and their respective fields are available for querying:

### User

```ruby
id: ID!
firstName: String!
lastName: String!
email: String!
phoneNumber: String!
role: String!
organizations: [Organization!]
```

### Organization

```ruby
id: ID!
name: String!
tours: Tour!
user: User!
```

### Tour

```ruby
id: ID!
name: String!
organization: Organization!
startDate: ISO8601Date!
endDate: ISO8601Date!
```

### Event

```ruby
id: ID!
name: String!
startTime: ISO8601DateTime!
endTime: ISO8601DateTime!
tour: Tour!
venue: Venue!
```

### SubEvent

```ruby
id: ID!
name: String!
description: String!
completed: Boolean!
endTime: ISO8601DateTime!
event: Event!
```

### Venue

```ruby
id: ID!
name: String!
address: String!
city: String!
state: String!
zip: String!
capacity: Int
```

### Contact

```ruby
id: ID!
firstName: String!
lastName: String!
email: String!
phoneNumber: String!
note: String
```

## Queries

***

### Find event by ID

`event(id: ID!): [Event!]!`

<b>GQL Example:</b>

```graphql
{
  event(id: 1) {
    id
    name
    startTime
    endTime
  }  
}
```
***

### Find all events

`events: [Event!]!`

<b>GQL Example:</b>

```graphql
{
  events {
    id
    name
    startTime
    endTime
  }  
}
```

***

### Find organization by ID

`organization(id: ID!): [Organization!]!`

***

### Find all organizations

`organizations: [Organization!]!`

***

### Find tour by ID

`tour(id: ID!): [Tour!]!`

***

### Find all tours

`tours: [Tour!]!`

***

### Find user by ID

`user(id: ID!): [User!]!`

***

### Find all users

`users: [User!]!`

***

### Find venue by ID

`venue(id: ID!): [Venue!]!`

***

### Find venue by name

`venueByName(name: String!): [Venue!]!`

***

### Find all venues

`venues: [Venue!]!`

***

### Find sub_event by ID

`subEvent(id: ID!): SubEvent!`

***

### Find sub_event by name

`subEventByName(name: String!): [Venue!]!`

***

### Find a contact by ID

`contact(id: ID!): Contact!`

***

### Find all contacts

`contacts: [Contact!]!`

## Mutations

Existing Mutations allow for Create, Update and Destroy actions to be made to the backend database.

The Input Types below describes input requirements. 

For example, in `createEvent(input: CreateEventInput!): Event`, 

- `CreateEventInput!` refers to the type defined below
- `: Event` defines the Type to expect in the response

***

### Create an organization belonging to a user

`createOrganization(input: CreateOrganizationInput!): Organization`


#### CreateOrganizationInput!

```ruby
name: String!
userId: Int!
```

***

### Update an organization

`updateOrganization(input: CreateOrganizationInput!): Organization`


#### UpdateOrganizationInput!

```ruby
id: Int!
name: String
userId: Int
```

***

### Destroy an organization

`destroyOrganization(input: CreateOrganizationInput!): Organization`


#### DestroyOrganizationInput!

```ruby
id: Int!
```

***

### Create a tour belonging to an organization

`createTour(input: CreateTourInput!): Tour`


#### CreateTourInput!

```ruby
organizationId: Int!
name: String!
startDate: ISO8601Date!
endDate: ISO8601Date!
```

***

### Update a tour

`updateTour(input: UpdateTourInput!): Tour`


#### UpdateTourInput!

```ruby
id: Int!
organizationId: Int
name: String
startDate: ISO8601Date
endDate: ISO8601Date
```

***

### Destroy a tour

`destroyTour(input: DestroyTourInput!): Tour`


#### DestroyTourInput!

```ruby
id: Int!
```

***

### Create an event belonging to a tour

`createEvent(input: CreateEventInput!): Event`


#### CreateEventInput!

```ruby
tourId: Int!
name: String!
venueId: Int!
startTime: ISO8601Date!
endTime: ISO8601Date!
```

<b>GQL Example:</b>

```graphql
mutation {
  createEvent(input: {
    tourId: 1,
    name: "Redrocks Night 1",
    venueId: 1,
    startTime: "2021-08-23T18:30:00-06:00",
    endTime: "2021-08-23T21:30:00-06:00"
  }) {
    id
    name
    startTime
    endTime
  }
}
```

<b>Using input object variables:</b>

```graphql
mutation createEvent($input: CreateEventInput!) {
  createEvent(input: $input) {
    id
    name
    startTime
    endTime
  }
}
```

<i>Query variables:</i>

```json
{ "input": {
    "tourId": 1,
    "name": "Redrocks Night 1",
    "venueId": 1,
    "startTime": "2021-08-23T18:30:00-06:00",
    "endTime": "2021-08-23T21:30:00-06:00"
  }
}
```

<details>
  <summary><b>Response:</b></summary>

```json
{
  "data": {
    "createEvent": {
      "id": "5",
      "name": "Redrocks Night 1",
      "startTime": "2021-08-23T00:00:00Z",
      "endTime": "2021-08-23T00:00:00Z"
    }
  }
}
```

</details></br>

***

### Update an event

`updateEvent(input: UpdateEventInput!): Event`


#### UpdateEventInput!

```ruby
id: Int!
tourId: Int
name: String
venueId: Int
startTime: ISO8601Date
endTime: ISO8601Date
```

***

### Destroy an event

`destroyEvent(input: DestroyEventInput!): Event`

#### DestroyEventInput!

```ruby
id: Int!
```

***

### Create a subEvent belonging to an event

`createSubEvent(input: CreateSubEventInput!): SubEvent`

#### CreateSubEventInput!

```ruby
eventId: Int!
name: String!
description: String!
startTime: ISO8601Date!
endTime: ISO8601Date!
```

GQL Example:

```graphql
mutation createSubEvent($input: CreateSubEventInput!) {
  createSubEvent(input: $input) {
    id
    name
    description
  }
}
```

Query vars

```json
{ "input": {
    "eventId": 1,
    "name": "DOTHESTUFFF",
    "description": "We gotta do the stuff",
    "startTime": "2021-08-23T18:30:00-06:00",
    "endTime": "2021-08-23T21:30:00-06:00"
  }
}
```

***

### Update a subEvent

`updateSubEvent(input: UpdateSubEventInput!): SubEvent`

#### UpdateSubEventInput!

```ruby
id: Int!
eventId: Int
name: String
description: String
startTime: ISO8601Date
endTime: ISO8601Date
```

GQL Example:

```graphql
mutation updateSubEvent($input: UpdateSubEventInput!) {
  updateSubEvent(input: $input) {
    id
    name
    description
  }
}
```

Query vars

```json
{ "input": {
    "eventId": 1,
    "name": "DOTHESTUFFF",
    "description": "We gotta do the stuff",
    "startTime": "2021-08-23T18:30:00-06:00",
    "endTime": "2021-08-23T21:30:00-06:00"
  }
}
```

***

### Destroy a subEvent

`destroySubEvent(input: DestroySubEventInput!): SubEvent`

#### DestroySubEventInput!

```ruby
id: Int!
```

***

### Create a contact belonging to a user

`createContact(input: CreateContactInput!): Contact`

#### CreateContactInput!

```ruby
userId: Int!
firstName: String!
lastName: String!
phoneNumber: String!
email: String!
note: String
```

GQL Example:

```graphql
mutation {
  createContact(input: {
    userId: 1,
    firstName: "Test",
    lastName: "Testerface",
    phoneNumber: "555-555-5555",
    email: "testerface@example.com",
    note: "Optional note"
  }) {
    firstName
    lastName
  }
}
```

***

### Update a contact

`updateContact(input: UpdateContactInput!): Contact`

#### UpdateContactInput!

```ruby
id: Int!
userId: Int
firstName: String
lastName: String
phoneNumber: String
email: String
note: String
```

GQL Example:

```graphql
mutation {
  updateContact(input: {
    id: 1,
    firstName: "Testa",
    lastName: "Testerfacer",
    phoneNumber: "555-555-5555",
    email: "testerface@example.com",
    note: "Changed note"
  }) {
    firstName
    lastName
    note
  }
}
```

***

### Destroy a contact

`destroyContact(input: DestroyContactInput!): Contact`

#### DestroyContactInput!

```ruby
id: Int!
```

<b>GQL Example:</b>

```graphql
mutation {
  destroyContact(input: {
    id: 11
  }) {
    id
  }
}
```

***

### Create a Venue

`createVenue(input: CreateVenueInput!): Venue`

#### CreateVenueInput!

```ruby
name: String!
address: String!
city: String!
state: String!
zip: String!
capacity: Int
```

<b>GQL Example:</b>

```graphql
mutation createVenue($input: CreateVenueInput!) {
  createVenue(input: $input) {
    id
    name
    address
    city
    state
    zip
    capacity
  }
}
```

Query variables:

```json
{ "input": {
    "name": "New Venue Test",
    "address": "123 Testing Street",
    "city": "Denver",
    "state": "CO",
    "zip": "80203",
    "capacity": 5000
  }
}
```

***

### Update a Venue

`updateVenue(input: UpdateVenueInput!): Venue`

#### UpdateVenueInput!

```ruby
id: ID!
name: String
address: String
city: String
state: String
zip: String
capacity: Int
```

GQL Example:

```graphql
mutation updateVenue($input: UpdateVenueInput!) {
  updateVenue(input: $input) {
    id
    name
  }
}
```

Query variables:

```json
{ "input": {
  "id": 12,
  "name": "Updated Venue Test"
  }
}
```

***

### Destroy a Venue

`destroyVenue(input: DestroyVenueInput!): Venue`

#### DestroyVenueInput!

```ruby
id: ID!
```

GQL Example:

```graphql
mutation destroyVenue($input: DestroyVenueInput!) {
  destroyVenue(input: $input) {
    id
  }
}
```

Query variables:

```json
{ "input": {
  "id": 12
  }
}
```

## Nested Query Examples

GraphQL allows relational queries to be made when associations between models exist.

For example, a Tour has many Events, and each Event belongs to a Venue. So the below nested query can be made:

- Query all `tours {...}`
  - sub-query for each tour's `events {...}`
    - sub-query each event's `venue {...}`

  <b>GQL Example</b>

  ```graphql
    {
      tours {
        id
        name
        events {
          id
          name
          startTime
          endTime
          venue {
            id
            name
            address
            city
            state
            zip
            capacity
          }
        }
      }
    }
  ```

<details>
  <summary><b>Response:</b></summary>

  ```
  {
  "data": {
    "tours": [
      {
        "id": "1",
        "name": "MVP Tour",
        "events": [
          {
            "id": "1",
            "name": "The Ramones",
            "startTime": "2021-04-21T02:19:28Z",
            "endTime": "2021-04-21T05:19:28Z",
            "venue": {
              "id": "7",
              "name": "Venue 7",
              "address": "413 Collen Plains",
              "city": "Denver",
              "state": "CO",
              "zip": "80203",
              "capacity": 4823
            }
          },
          {
            "id": "2",
            "name": "U2",
            "startTime": "2021-04-22T00:22:33Z",
            "endTime": "2021-04-22T03:22:33Z",
            "venue": {
              "id": "6",
              "name": "Venue 6",
              "address": "7397 Erma Run",
              "city": "Denver",
              "state": "CO",
              "zip": "80203",
              "capacity": 3540
            }
          }
        ]
      }
    ]
  }
}
```

</details></br>

To take it a few nodes further...

- Query `user(id: 1)`
  - query the user's `contacts {...}`
  - query the user's `organizations {...}`
    - Query each organization's `tours {...}`
      - sub-query for each tour's `events {...}`
        - sub-query for each event's `sub_events {...}`
      - sub-query each event's `venue {...}`

<details>
  <summary><b>GQL Example</b></summary>

  
```graphql
{
  user(id:1) {
    contacts {
      id
      firstName
      lastName
      email
      phoneNumber
      note
    }
    organizations {
      tours {
        id
        name
        events {
          id
          name
          startTime
          endTime
          subEvents {
            id
            name
            description
            startTime
            endTime
            completed
          }
          venue {
            id
            name
            address
            city
            state
            zip
            capacity
          }
        }
      }
    }
  }
}
```

</details>
