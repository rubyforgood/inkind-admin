before: Volunteer has contact info for one (or more) students. They set up meetings as needed, typically once a week.

problems:

- collecting time info about meetings is difficult
- soliciting feedback about meetings is difficult
- soliciting honest feedback from students is difficult

### Email based flow

(desktop) 1. Admin generates a survey link: https://team.cep/survey?email=volunteer@example.com&student=123

- how did admin get in?
- how did they pick a volunteer?
- how did they pick a student?
- how did they pick a survey?
- can we pre-create a survey response with pre-populated student?
- can we schedule survey response solicitation emails?

(mobile) 2. Volunteer follows link, arrives at survey page

(mobile) 3. Volunteer fills out survey.

(mobile) 3b. (optional:tickets) Volunteer requests contact.

(desktop) 4. Admin looks at collected responses.

(desktop) 4b. (optional:tickets) Admin contacts volunteer.

### Invite based flow

(desktop) 1. Admin adds Students and Volunteers and associates Students with Volunteers.

(backend) 2. Volunteers get invitation links.

(mobile) 3. Volunteer visits their dashboard, sees list of students.

(mobile) 4. Volunteer clicks on Student, arrives at survey page.

(continue from step 3 above)

but first...

### Admin invitation flow

1. admin creates volunteer
2. admin creates student
3. admin assigns student to volunteer
4. admin sends volunteer invite

but first...

### 000. Admin can sign in

1. admin exists in user table
2. admin goes to login screen
3. admin puts in email and password

### 001. Admin can create/edit/delete Student

1. admin can see student#index
2. admin goes to student create form
3. admin puts in name, saves student

### 002. Admin can create create/edit/delete Volunteer (User)

1. admin can see users#index
2. admin goes to user create form
3. admin puts in name, email, and role; saves user

### 003. Admin can see survey responses

1. admin can see survey_responses#index
2. there's a table of survey responses
