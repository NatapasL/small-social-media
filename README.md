# README

## Setup Instruction  
1. Install bundle  
```bash
$ bundle install
```  

2. Add `devise_jwt_secret_key` to secret  
- 2.1 Generate secret.  
```bash
$ bin/rails secret
```  
- 2.2 Open `credentials.yml.enc`  
```
$ EDITOR="vim" credentials:edit
```  
- 2.3 Add secret generated in 2.1 to credentials  
```yaml
  ...
  devise_jwt_secret_key: [secret generated in 2.1]
```  

3. Run db migrate.
```bash
$ rake db:migrate
```

4. Start rails server, by default should be on port :3000.  
```bash
$ rails s
```  

## How to run test  
After successfully setup from instruction above, test can be run right awy.  
```bash
rspec .
```

## How to use
1. Register at `POST /signup`.  

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

2. Log in at `POST /login`.  

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
Token will be at header `authorization` in response.  

3. Add token from 2. to header `Authorization`.
```bash
curl \
--header 'Authorization: Bearer [TOKEN]' \
...
```
- 3.1 Get all posts at `GET /posts`.  
```bash
curl \
--location 'http://localhost:3000/posts' \
--header 'Authorization: Bearer [TOKEN]'
```

- 3.2 Create post at `POST /posts`.  
```bash
curl \
--location 'http://localhost:3000/posts' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
--data '{
    "post": { "text": "this is a text" }
}'
```

- 3.3 Show post at `GET /posts/:id`.  
```bash
curl \
--location 'localhost:3000/posts/:id' \
--header 'Authorization: Bearer [TOKEN]'
```

- 3.4 Update post at `PUT /posts/:id`.  
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

- 3.5 Delete post at `DELETE /posts/:id`.  
```bash
curl \
--location \
--request DELETE 'localhost:3000/posts/:id' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer [TOKEN]' \
```