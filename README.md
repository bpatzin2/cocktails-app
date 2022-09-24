# cocktails-app

This is a side project where I'm working building a cocktail receipe search app. 
I'm over-engineering it as I'm using the oppurtunity to play with technologies I'm interested int.


### TODO
- Get typescript working to fix the build
- Design what the actual app behavior should be
- build it

### How to run it locally
From `frontend/cocktails`, run `yarn dev`

### Build & Deploy
There's a github action that runs on every merge to master that generates a docker container and uploads it to ECR. 

Deploy Process
- Uncomment main.tf
- terraform apply -var="image_tag=main-0b7d17a"
- To cleanup: comment code, terraform apply

### Product Ideas
Allow for searching of cocktail recepies based on 
- what ingredients I have
- what ingredients I can get (citrus is easier to get than a new bottle)
- what type of drink I want
- what recepies I've like/rated in the past
- variations on cocktails/recepies that I've liked

### Technologies I want to play with
- Cloud/AWS
- Docker
- Typescript
- Next.js
- Prisma
- Frontend/Styling/CSS
