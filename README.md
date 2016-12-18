# My first project using NodeJS and Coffee-script

![Build](https://travis-ci.org/daniel-ece/myfirstproject.svg?branch=master)

Simple dashboard app :
* User login
* A user can insert metrics
* A user can retrieve his metrics in a graph
* A user can only access his own metrics

## Requirement
### For using coffee-script
```
npm install coffee-script
```

### For the test (using mocha & should)
```
npm install mocha
npm install should
```

### Make scripts executable
```
chmod +x bin/
```
Look at the dependencies in package.JSON

## Run
Run the app on : http://localhost:1337
```
bin/start
```
or
```
npm start
```

## Test
Execute some unit tests
```
bin/test
```
or
```
npm test
```

## Transpilers
Transpile coffee-scripts' files into javascript
```
bin/build
```
or
```
npm build
```

Transpile stylus into css
```
bin/stylus
```
or
```
npm stylus
```

## Populate the database
Populate the database with dummy users and metrics
```
bin/populatedb
```
or
```
npm populatedb
```
