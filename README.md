# Mongo test test

A test app to try out the functionality of [mongodb](http://www.mongodb.org/).

## Installation

1. [Install mongodb](http://www.mongodb.org/display/DOCS/Quickstart+OS+X)

## Development

To set up

    gem install bundler
    bundle install

To run

    foreman start dev
    # open http://localhost:5000/
    
A nice mongodb gui: http://mongohub.todayclose.com/

## Deployment

Deployed on [heroku](http://www.heroku.com/).

To set up RACK_ENV on heroku

   heroku config:add RACK_ENV=production

To deploy (assuming heroku settings are set up)

   git push heroku master

Uses [MongoLab](http://devcenter.heroku.com/articles/mongolab)

This is deployed at: http://mongotesttest.herokuapp.com/