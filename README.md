# README

## Setup Instructions  
1. Install dependencies:  
```bash
$ bundle install
```  

2. Add `devise_jwt_secret_key` to credentials:  
- 2.1 Generate a secret:  
```bash
$ bin/rails secret
```  
- 2.2 Open `credentials.yml.enc` for editing:  
```
$ EDITOR="vim" credentials:edit
```  
- 2.3 Add secret generated in 2.1 to credentials:  
```yaml
  ...
  devise_jwt_secret_key: [secret generated in 2.1]
```  

3. Run database migration:
```bash
$ rake db:migrate
```

4. Start the rails server (default port: 3000):  
```bash
$ rails s
```  

## Running tests  
After completing the setup instructions, you can run the tests with:  
```bash
rspec .
```

## Usage
1. Register a new user at `POST /signup`:  

```bash
# Request
curl \
--location 'http://localhost:3000/signup' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "test@email.com",
        "password": "123456"
    }
}'

# Resonse
{"id":7,"email":"test@email.com"}
```

2. Log in at `POST /login`:  

```bash
# Request
curl -i \
--location 'http://localhost:3000/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "test@email.com",
        "password": "123456"
    }
}'

# Response
HTTP/1.1 200 OK
...
authorization: Bearer [TOKEN]
...

{"id":7,"email":"test@email.com"}
```
The token will be returned in the `Authorization` header of the response.  

3. Use the token from step 2 in subsequent requests:  

```bash
curl \
--header 'Authorization: Bearer [TOKEN]' \
...
```

- 3.1 Get all posts at `GET /posts`:  

```bash
# Request
curl \
--location 'http://localhost:3000/posts' \
--header 'Authorization: Bearer [TOKEN]'

# Response
[
  {
    "id": 1,
    "text": "sample post",
    "created_at": "2024-08-08T20:17:11.244Z",
    "updated_at": "2024-08-08T20:17:11.244Z",
    "created_by_id": 1
  },
  {
    "id": 2,
    "text": "sample post 2",
    "created_at": "2024-08-08T20:25:44.956Z",
    "updated_at": "2024-08-08T20:25:44.956Z",
    "created_by_id": 1
  }
]
```

- 3.2 Create a post at `POST /posts`:  

```bash
# Request
curl \
--location 'http://localhost:3000/posts' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
--data '{
    "post": { "text": "this is a text" }
}'

# Response
{
  "id": 5,
  "text": "this is a text",
  "created_at": "2024-08-11T17:13:37.494Z",
  "updated_at": "2024-08-11T17:13:37.494Z",
  "created_by_id": 6
}
```

- 3.3 Show a specific post at `GET /posts/:id`:  

```bash
# Request
curl \
--location 'localhost:3000/posts/:id' \
--header 'Authorization: Bearer [TOKEN]'

# Response
{
  "id": 5,
  "text": "this is a text",
  "created_at": "2024-08-11T17:13:37.494Z",
  "updated_at": "2024-08-11T17:13:37.494Z",
  "created_by_id": 6
}
```

- 3.4 Update a post at `PUT /posts/:id`:  

```bash
# Request
curl \
--location \
--request PUT 'http://localhost:3000/posts/:id' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
--data '{
    "post": { "text": "This is updated text" }
}'

# Response
{
  "id": 5,
  "text": "This is updated text",
  "created_at": "2024-08-11T17:13:37.494Z",
  "updated_at": "2024-08-11T17:20:10.076Z",
  "created_by_id": 6
}
```

- 3.5 Delete a post at `DELETE /posts/:id`:  

```bash
# Request
curl -I \
--location \
--request DELETE 'localhost:3000/posts/:id' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]'

# Response
HTTP/1.1 200 OK
...
```