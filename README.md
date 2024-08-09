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
curl \
--location 'http://localhost:3000/signup' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "test@email.com",
        "password": "123456"
    }
}'
```

2. Log in at `POST /login`:  

```bash
curl -i \
--location 'http://localhost:3000/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "test@email.com",
        "password": "123456"
    }
}'
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
curl \
--location 'http://localhost:3000/posts' \
--header 'Authorization: Bearer [TOKEN]'
```

- 3.2 Create a post at `POST /posts`:  

```bash
curl \
--location 'http://localhost:3000/posts' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
--data '{
    "post": { "text": "this is a text" }
}'
```

- 3.3 Show a specific post at `GET /posts/:id`:  

```bash
curl \
--location 'localhost:3000/posts/:id' \
--header 'Authorization: Bearer [TOKEN]'
```

- 3.4 Update a post at `PUT /posts/:id`:  

```bash
curl \
--location \
--request PUT 'http://localhost:3000/posts/:id' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
--data '{
    "post": { "text": "This is updated text" }
}'
```

- 3.5 Delete a post at `DELETE /posts/:id`:  

```bash
curl \
--location \
--request DELETE 'localhost:3000/posts/:id' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
```