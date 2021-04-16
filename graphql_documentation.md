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
venues: Venue!
```

### Venue

```ruby
id: ID!
name: String!
address: String!
city: String!
state: String!
zip: String!
capacity: Int!
```


## Queries

### Find event by ID

`event(id: ID!): [Event!]!`

GQL Example:

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

Return: 

### Find all events

`events: [Event!]!`

GQL Example:

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

## Mutations

### Create an event belonging to a tour

`createEvent(input: CreateEventInput!): Event`

GQL Example:

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

Response:

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

## Nested Query Example

Query all tours

  - sub-query for each tour's events
    - sub-query each event's venues

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
        venues {
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

Response:

```
{
  "data": {
    "tours": [
      {
        "id": "1",
        "name": "MVP Tour",
        "events": [
          {
            "id": "2",
            "name": "Redrocks Night 1",
            "startTime": "2021-08-23T00:00:00Z",
            "endTime": "2021-08-23T00:00:00Z",
            "venues": [
              {
                "id": "1",
                "name": "Red Rocks Park and Amphitheatre",
                "address": "18300 W Alameda Pkwy",
                "city": "Morrison",
                "state": "CO",
                "zip": "80465",
                "capacity": 9525
              }
            ]
          },
          {
            "id": "3",
            "name": "Redrocks Night 2",
            "startTime": "2021-08-24T00:00:00Z",
            "endTime": "2021-08-24T00:00:00Z",
            "venues": [
              {
                "id": "1",
                "name": "Red Rocks Park and Amphitheatre",
                "address": "18300 W Alameda Pkwy",
                "city": "Morrison",
                "state": "CO",
                "zip": "80465",
                "capacity": 9525
              }
            ]
          },
          {
            "id": "4",
            "name": "Redrocks Night 3",
            "startTime": "2021-08-25T00:00:00Z",
            "endTime": "2021-08-25T00:00:00Z",
            "venues": [
              {
                "id": "1",
                "name": "Red Rocks Park and Amphitheatre",
                "address": "18300 W Alameda Pkwy",
                "city": "Morrison",
                "state": "CO",
                "zip": "80465",
                "capacity": 9525
              }
            ]
          },
          {
            "id": "5",
            "name": "Redrocks Night 4",
            "startTime": "2021-08-26T00:00:00Z",
            "endTime": "2021-08-26T00:00:00Z",
            "venues": [
              {
                "id": "1",
                "name": "Red Rocks Park and Amphitheatre",
                "address": "18300 W Alameda Pkwy",
                "city": "Morrison",
                "state": "CO",
                "zip": "80465",
                "capacity": 9525
              }
            ]
          }
        ]
      }
    ]
  }
}
```
