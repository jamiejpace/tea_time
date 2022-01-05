# <div align="center">Tea Time</div>

### Overview

Tea Time is a rails API for a tea subcription service

#### Framework
<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

#### Languages
<p>
  <img src="https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white" />
</p>

#### Tools
<p>
  <img src="https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white" />  
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  <img src="https://img.shields.io/badge/Postman-FF6E4F.svg?&style=flat&logo=postman&logoColor=white" />
</p>

#### Gems
<p>
  <img src="https://img.shields.io/badge/rspec--rails-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />   
  <img src="https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
</p>

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />  
</p>


### <ins>Contributors</ins>

👤  **Jamie Pace**
- Github: [Jamie Pace](https://github.com/jamiejpace)
- LinkedIn: [Jamie Pace](https://www.linkedin.com/in/jamiejpace/)


![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

### Local Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Set up the database: `rails db:{drop,create,migrate,seed}`

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

### Database Schema

<img width="908" alt="Screen Shot 2022-01-05 at 10 25 31 AM" src="https://user-images.githubusercontent.com/81520519/148261506-e1e4e822-9fdf-4d91-b135-783f60cbb836.png">

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

### Endpoints

#### Create a customer:

*Request*

`POST /api/v1/customers`

Request body:
```
{
    "first_name": "Ruby",
    "last_name": "Dog",
    "email": "woof@dogmail.com",
    "address": "Street, City, State"
}
```

*Response*
```
{
    "data": {
        "id": "2",
        "type": "customer",
        "attributes": {
            "first_name": "Ruby",
            "last_name": "Dog",
            "email": "woof@dogmail.com",
            "address": "Street, City, State"
        }
    }
}
```

#### Create a tea:

*Request*

`POST /api/v1/teas`

Request body:
```
{
    "title": "Orange Blossom Black Tea",
    "description": "Flower and fruity",
    "temperature": "99",
    "brew_time": "5 minutes"
}
```

*Response*
```
{
    "data": {
        "id": "2",
        "type": "tea",
        "attributes": {
            "title": "Orange Blossom Black Tea",
            "description": "Flower and fruity",
            "temperature": 99,
            "brew_time": "5 minutes"
        }
    }
}
```

#### Create a subscription for a customer:

*Request*

`POST /api/v1/customers/:cutomer_id/subscriptions`

Request body:
```
{
    "tea_id": "1",
    "frequency": "weekly",
    "title": "example",
    "price": "20.00"
}
```

*Response*
```
{
    "data": {
        "id": "6",
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "tea_id": 1,
            "title": "example",
            "price": 20.0,
            "frequency": "weekly",
            "status": "active"
        }
    }
}
```

#### Cancel a tea subscription for a customer:

*Request*

`PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id?status=cancelled`

*Response*
```
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "tea_id": 1,
            "title": "test",
            "price": 10.0,
            "frequency": "weekly",
            "status": "cancelled"
        }
    }
}
```

#### View all subscriptions (active and cancelled) for a customer:

*Request*

'GET /api/v1/customers/:customer_id/subscriptions'

*Response*
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 1,
                "title": "test",
                "price": 10.0,
                "frequency": "weekly",
                "status": "cancelled"
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 2,
                "title": "example",
                "price": 12.0,
                "frequency": "monthly",
                "status": "active"
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 3,
                "title": "example",
                "price": 20.0,
                "frequency": "yearly",
                "status": "active"
            }
        }
    ]

}
```
