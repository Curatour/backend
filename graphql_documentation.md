# Curatour GraphQL API

## Types

Each GraphQL Type represents the models and their respective attributes available for querying and mutating. The following Types and respective fields are available from the `https://curatour-be.herokuapp.com/graphql` endpoint:

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

### Find organization by ID

`organization(id: ID!): [Organization!]!`

### Find all organizations

`organizations: [Organization!]!`

### Find tour by ID

`tour(id: ID!): [Tour!]!`

### Find all tours

`tours: [Tour!]!`

### Find user by ID

`user(id: ID!): [User!]!`

### Find all users

`users: [User!]!`

### Find venue by ID

`venue(id: ID!): [Venue!]!`

### Find venue by name

`venueByName(name: String!): [Venue!]!`

### Find all venues

`venues: [Venue!]!`

### Find sub_event by ID

`subEvent(id: ID!): SubEvent!`

### Find sub_event by name

`subEventByName(name: String!): [Venue!]!`

### Find a contact by ID

`contact(id: ID!): Contact!`

### Find all contacts

`contacts: [Contact!]!`

## Mutations

Existing Mutations allow for Create, Update and Destroy actions to be made to the backend database.

The Types section above defines fields available for querying, and the Input Types below describes input requirements.

### Input Types

#### CreateEventInput!

```ruby
tourId: Int!
name: String!
venueId: Int!
startTime: ISO8601Date!
endTime: ISO8601Date!
```

#### CreateOrganizationInput!

```ruby
name: String!
userId: Int!
```

#### CreateTourInput!

```ruby
organizationId: Int!
name: String!
startDate: ISO8601Date!
endDate: ISO8601Date!
```

#### DestroyEventInput!

```ruby
id: Int!
```

#### DestroyOrganizationInput!

```ruby
id: Int!
```

#### DestroyTourInput!

```ruby
id: Int!
```

#### UpdateEventInput!

```ruby
id: Int!
tourId: Int
name: String
venueId: Int
startTime: ISO8601Date
endTime: ISO8601Date
```

#### UpdateOrganizationInput!

```ruby
id: Int!
name: String
userId: Int
```

#### UpdateTourInput!

```ruby
id: Int!
organizationId: Int
name: String
startDate: ISO8601Date
endDate: ISO8601Date
```

#### CreateContactInput!

```ruby
userId: Int!
firstName: String!
lastName: String!
phoneNumber: String!
email: String!
note: String
```

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

#### DestroyContactInput!

```ruby
id: Int!
```

### Create an event belonging to a tour

`createEvent(input: CreateEventInput!): Event`

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

Using Input Object:

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
Query vars
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

### Create an organization belonging to a user

`createOrganization(input: CreateOrganizationInput!): Organization`

### Create a tour belonging to an organization

`createTour(input: CreateTourInput!): Tour`

### Destroy an event

`destroyEvent(input: DestroyEventInput!): Event`

### Destroy an organization

`destroyOrganization(input: CreateOrganizationInput!): Organization`

### Destroy a tour

`destroyTour(input: DestroyTourInput!): Tour`

### Update an event

`updateEvent(input: UpdateEventInput!): Event`

### Update an organization

`updateOrganization(input: CreateOrganizationInput!): Organization`

### Update a tour

`updateTour(input: UpdateTourInput!): Tour`

### Create a contact belonging to a user

`createContact(input: CreateContactInput!): Contact`

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

### Update a contact

`updateContact(input: UpdateContactInput!): Contact`

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

### Destroy a contact

`destroyContact(input: DestroyContactInput!): Contact`

GQL Example:

```graphql
mutation {
  destroyContact(input: {
    id: 11
  }) {
    id
  }
}
```

## Nested Query Example

Query all tours

  - sub-query for each tour's events
    - sub-query each event's venue

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
