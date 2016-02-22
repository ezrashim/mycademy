#Mycademy: Learn to Lead#

![Build Status](https://codeship.com/projects/b2531260-9965-0133-f25f-2e043ba8a616/status?branch=master)
![Code Climate](https://codeclimate.com/github/ezrashim/mycademy.png)
![Coverage Status](https://coveralls.io/repos/ezrashim/mycademy/badge.png)


##What is Mycademy?##
Mycademy is a personal online teaching platform designed using Test Driven Development. The project integrates Twilio API, Tinymce Editor, and Materialize frontend with custom Sass into Ruby on Rails with PostgreSQL database.

Mycademy is a place where users can design and lead their own curriculum. Users can create a course and view student progress instantly. Also, course leaders can connect with students easily through the integrated text messaging option.

Please visit the [website](https://mycademy.herokuapp.com/)!

##ER Diagram##
[https://drive.google.com/file/d/0B1xviAR28LmqWlJjd0VJUUxmb0k/view?usp=sharing](https://drive.google.com/file/d/0B1xviAR28LmqWlJjd0VJUUxmb0k/view?usp=sharing)

##Demo##

[Screencast](https://vimeo.com/156280156)

##Development##
- Ruby (version 2.0.0)
- Rails (version 4.2.5)
- PostgreSQL (version 9.4.5.0)
- Materialize
- Devise
- Tinymce-rails
- Twilio-ruby (version 4.2.1)

##Testing##

To run the test, you need to clone to repository and install bundle. All required gems are listed in the Gemfile.

- Install [bundle](http://bundler.io/).
```
git clone github.com/ezrashim/mycademy.git
cd mycademy
bundle install
```

- To prepare for testing, run:
```
rake db:test:prepare
```

- To run all test files, run:
```
rake
```

- You may specify an individual test file to run using rspec:
```
rspec <full test name>
```

- For example:
```
rspec spec/features/answers/create_spec.rb
```
