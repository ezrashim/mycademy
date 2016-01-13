![Build Status](https://codeship.com/projects/b2531260-9965-0133-f25f-2e043ba8a616/status?branch=master)
![Code Climate](https://codeclimate.com/github/ezrashim/mycademy.png)
![Coverage Status](https://coveralls.io/repos/ezrashim/mycademy/badge.png)


[Mycademy ER Diagram Initial](https://drive.google.com/file/d/0B1xviAR28LmqNV8yckQyU2hxTlU/view?usp=sharing)
[Mycademy ER Diagram Upgrade](https://drive.google.com/file/d/0B1xviAR28LmqWlJjd0VJUUxmb0k/view?usp=sharing)

**User Stories**

Users can create membership accounts:

  As a prospective user
  I want to create an account
  So that I can create or join courses.

  *Option 1:*
    -I must specify a valid email address.
    -I must specify a password, and confirm that password.
    -If I do not perform the above, I get an error message.
    -If I specify valid information, I register my account and am authenticated.

  *Option 2:*
    -I must click 'sign up via facebook' button.
    -If I click 'Sign Up' button, I register my account and am authenticated.

  As an unauthenticated user
  I want to sign in
  So that I can create or join courses.

    -I must enter a user's email address.
    -I must enter a user's password.
    -If I do not perform the above, I get an error message.
    -If I specify valid information, I sign in to my account and am authenticated.

  As an unauthenticated user
  I want to sign out
  So that my identity is forgotten on the machine I am using.

    -If I am signed in, I have an option to sign out
    -When I am opted to sign out, I get a confirmation that my identity has been forgotten on the machine I am using.

  As an unauthenticaed user
  I want to view all the courses
  So that I can decide if I want to sign up or not.

    -If am not signed in, I can view all the list of courses, but cannot view any button for 'I want in!' or 'Create'

  As an authenticated user
  I want to delete my account
  So that my identity is forgotten on the app entirely.

    -If I am signed in, I have an option to delete my account.
    -When I delete my account, I get a confirmation that my account has been deleted from the app.

Users can create courses as Leaders:

  As an authenticated Leader
  I want to create a course
  So that I can invite Learners to the course.

    -If I am signed in, I have an option to click 'Join as a Leader'.
    -If I am authenticated as a 'Leader' I can create a new course and invite new learners.
    -If I am not authenticated as a 'Learner', I cannot view 'Create a Course' link.

  As an authenticated Leader
  I want to view the list of courses I created
  so that I can view the details of each course.

    -If I am authenticated as a 'Leader' I can view the list of courses I created.

  As an authenticated Leader
  I want to edit the list of courses I created
  so that I can improve the details of each course.

    -If I am authenticated as a 'Leader' I can update the details (title, body, duration, etc.) of the course.

  As an authenticated Leader
  I want to delete the list of courses I created
  so that I can clear any obsolete course.

    -If I am authenticated as a 'Leader' I can destroy any course on the list of my courses.

Users can join courses as students:

  As an authenticated Learner
  I want to view and join a course
  So that I can learn from the Leader in a course.

    -If I am signed in, I have an option to click 'Join as a Learner'.
    -If I am authenticated as a 'Learner' I can view the list of upcoming courses.
    -If I am authenticated as a 'Learner' I can join a course of my choice.
    -If I am not authenticated as a 'Learner', I cannot view 'Join a Course' link.

  As an authenticated Learner
  I want to view the list of courses I joined
  so that I can view my progress in each course.

    -If I am authenticated as a 'Learner' I can view the list of courses I joined.
    -I can view the progress of each course I joined.

  As an authenticated Learner
  I want to opt out from any course I joined
  so that I can discontinue the course.

    -If I am authenticated as a 'Learner' I can leave the course.


          #pending
          -create lessons
          -upload videos
          -upload pictures
          -create assignments as leader
          -grade assignments as leader
          -view progress report
          -create slack channel
          -send announcements through slack
          -send automatic reminders through slack
          -mailer email invites
          -search course function
          -submit assignment as learner
