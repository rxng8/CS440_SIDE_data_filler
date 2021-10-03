# MySQL Docker Container

To build the root image run in this directory:
`docker build -t 330259559134.dkr.ecr.us-east-1.amazonaws.com/affordhealth/db:dev .`

To run the MySQL container run in this directory:
`docker run --name some-mysql --env-file=.env -p 3306:3306 330259559134.dkr.ecr.us-east-1.amazonaws.com/affordhealth/db:dev`
