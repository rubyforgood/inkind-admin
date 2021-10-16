[![rspec](https://github.com/rubyforgood/inkind-admin/workflows/rspec/badge.svg)](https://github.com/rubyforgood/inkind-admin/actions/workflows/rspec.yml)
[![linting](https://github.com/rubyforgood/inkind-admin/actions/workflows/ruby_lint.yml/badge.svg)](https://github.com/rubyforgood/inkind-admin/actions/workflows/ruby_lint.yml)

# InKind - Supporting Community Education Partnerships

This repository is the backend code for an application named InKind, which is a [Ruby For Good](https://rubyforgood.org/) project serving [Community Education Partnerships](https://www.cep.ngo/) (CEP).

Community Education Partnerships' mission is to increase the learning opportunities and enhance the academic achievement of students experiencing homelessness and housing insecurity. Community Education Partnerships offers its students: individualized tutoring and mentoring, backpacks, school supplies, books, learning resources, enrollment assistance, and opportunities to participate in extracurricular enrichment activities.

This app tracks volunteer and student data, and feedback from the mentoring sessions that are a core part of CEP's programming. These sessions provide vital stability to young people who lack access to learning opportunities and face a multitude of challenges that affect their educational outcomes. CEP volunteers form lasting relationships with students, and communicate their needs of food insecurity and other necessities to CEP, ensuring that staff members are able to facilitate the appropriate support for students, and by extension, their families. This app will enable CEP to collect and analyze critical data, facilitate quicker response times to requests for support, and enable them to apply for grant funding, ensuring that their work remains sustainable.

The counterpart to this codebase is [`inkind-volunteer`](https://github.com/rubyforgood/inkind-volunteer), which houses a Typescript/React mobile first codebase used by the volunteers to record data from their mentoring sessions with students.

# Welcome Contributors!

Thanks for checking us out!
  - Check the `CONTRIBUTING.md` file for a guide on how to get started
  - This is a 100% volunteer-supported project, please be patient with your correspondence. Most (all?) of us have day jobs and so responses to questions / pending PRs may not be immediate. Please be patient, we'll get to you! :)

Please feel encouraged to join us on Slack! You can sign up at https://rubyforgood.herokuapp.com

We're in #team-inkind

# Setup

## Installation

#### Ruby

1. Install a ruby version manager: [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies), [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv)
1. Once you cd into the project directory, let your version manager install the ruby version. Right now that's Ruby 3.0.2
1. `gem install bundler`

#### PostgreSQL ("postgres")

1. Make sure that postgres is installed.
  - If you're on MacOS, we recommend using homebrew, `brew install postgresql`
  - If you're on Ubuntu/WSL, use `sudo apt-get install libpq-dev` so the gem can install. [Use the Postgres repo for Ubuntu or WSL to get the server and client tools](https://www.postgresql.org/download/linux/ubuntu/).
  - If you're on Fedora/Cent Os use `sudo dnf install libpq-devel`. [If you prefer choose package of libpq-devel via rpm](https://pkgs.org/download/libpq-devel)
  - If you're on Windows, use the official [installer](https://www.postgresql.org/download/windows/) and accept all defaults.  Alternatively, a [Chocolatey](https://chocolatey.org/packages/postgresql) package is available with `choco install postgresql`.

#### Downloading the Project

1. Fork this repository and clone down a copy. See [our contributing guide](CONTRIBUTING.md) for detailed instructions.

#### Installing Packages

1. `cd inkind-admin/`
1. Run `bundle install` to install ruby dependencies.

#### Database Setup

1. Use `bin/rails db:setup` to create schema and seed some data. This requires running postgres locally, with a role created for whatever user you're running rails as.

#### Front-end

1. Run `yarn install`

#### Server

1. Run `bin/server`
1. To be able to run the volunteer application (`inkind-volunteer`) in tandem, localhost for this repository runs on port 3001. So launch `inkind-admin` from your browser at `http://localhost:3001/`

## Tests

#### Chrome

System tests use Chrome Browser and Chromedriver.

1. To install Chrome, see [Chrome Install](https://support.google.com/chrome/answer/95346?hl=en&ref_topic=7439538).
1. For Chromedriver (on Mac), we recommend using homebrew, `brew install --cask chromedriver`. Then `cd` into the directory it installed in (`which chromedriver`) and mark it as safe to use with `xattr -d com.apple.quarantine chromedriver`.

#### Running tests

1. Run `bin/rspec`

## Logging in

Seeding data creates one "admin" user for you to log in as locally.

To log in as an admin:

Email: admin@cep.dev
Password: password

To log in as a volunteer:

Email: volunteer@cep.dev
Password: password

## Working with GraphQL

- When making changes to Graphql, make sure to run `rails graphql:schema:dump` to update the schema and IDL with the changes.

## Setup Instructions for full-stack application

1. Visit https://github.com/rubyforgood/inkind-volunteer for instructions on how to run the Rails & React application together.
