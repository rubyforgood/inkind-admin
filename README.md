# Welcome!

This repository is the backend code for an application named InKind, which is a [Ruby For Good](https://rubyforgood.org/) project serving [Community Education Partnerships](https://www.cep.ngo/) (CEP). CEP supports the education of Bay area children facing homelessness and housing insecurity since 2010.

The counterpart to this codebase is [`inkind-volunteer`](https://github.com/rubyforgood/inkind-volunteer), which houses a Typescript/React mobile first codebase used by volunteers to track their mentoring sessions with students.

# Development Setup

## Installation

### Setup Instructions for backend (this repo)

#### Ruby

1. Install a ruby version manager: [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies), [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv)
1. Once you cd into the project directory, let your version manager install the ruby version. Right now that's Ruby 3.0.1
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

#### Server

1. Run `bin/rails s`
1. To be able to run the frontend (`inkind-volunteer`) in tandem, localhost for this repository runs on port 3001. So launch `inkind-admin` from your browser at `http://localhost:3001/`

#### Tests

1. Run `bin/rspec`

### Setup Instructions for full-stack application

1. Visit https://github.com/rubyforgood/inkind-volunteer for instructions on how to run the Rails & React application together.

# Communication and Collaboration

Most conversations happen in the #team-inkind channel of the Ruby For Good Slack. Get access here: https://rubyforgood.herokuapp.com/

You can also open an issue or comment on an issue on github and a maintainer will reply to you.

Info to join all public meetings are posted in the rubyforgood Slack!
