# README

## Running the thing locally

So, this is designed to be ran like a standard Rails application against a PostgreSQL
database. Or, for simplicity sake, the application has been bundled up into a `Dockerfile`
with an accompanying `docker-compose.yml` to run the application with Docker Compose.

To start the app, simply run `docker-compose up` in a terminal. Docker Compose will take
care of the rest. The application will be accessible at `http://localhost:3000`

## Run the tests!

The test suite can also be ran in Docker Compose!

The command to do that is:

`docker-compose -f docker-compose.yml -f docker-compose.test.yml run app rake`

## Database schema

The data is stored following this schema:

![Database schema](docs/schema.png?raw=true)

## Scaling the thing

Here is a list of things that I would do different for scalability:

* **Sidekiq** - Implement the form processing and import process as a Sidekiq job instead 
of just a controller action. The controller action is prone to race conditions and network
disruptions. A Sidekiq job could execute the job asynchronously and handle restarts gracefully.
Also, it would prevent weird race conditions that could result from multiple writes occurring simultaneously.

* **Database schema** - The schema is relatively scalable, but is probably missing some useful information. Notably,
storage of upload requests for internal bookkeeping. Also, it does make a lot of assumptions about the data.

* **UI/UX** - The table will just infinitely grow and does not implement pagination. This would need need to
be changed to paginate when there is too much data. Also, there are plenty of missing features here around updating
existing data or adding data without a spreadsheet. We could also generate different reports.

* **React** - I used StimulusJS for simplicity, but I would use React for a real version of this given
sufficiently complex requirements for the front-end application. Also, the front-end should be wholly decoupled
from the backend API so frontend and backend systems can be scaled independently. Also, clearer separation
of system concerns than a pure monorepo would provide.

* **Authentication** - Authentication definitely needs to be added and given that I used Rails, I would just use the Devise gem.
