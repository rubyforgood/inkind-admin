down:
	@echo -
	@echo - Drop 'data' folder to delete DB files /pg and redis/
	@echo -
	$(MAKE) env env=dev cmd=down

build:
	docker-compose -f dc.common.yml -f dc.dev.yml build app

env:
	docker-compose -f dc.common.yml -f dc.$(env).yml $(cmd)

env_up:
	$(MAKE) env cmd=up

env_run:
	$(MAKE) env cmd="run -p 3001:3000 --rm app \"$(cmd)\""

up:
	$(MAKE) env_up env=dev

ci_up:
	$(MAKE) env env=ci cmd="up -d"

run:
	$(MAKE) env_run env=dev cmd="$(cmd)"

ci_run:
	$(MAKE) env_run env=ci cmd="$(cmd)"

test:
	$(MAKE) run cmd=bin/rspec

lint:
	$(MAKE) run cmd="standardrb --format github"

ci_test:
	$(MAKE) ci_run cmd=bin/rspec

console:
	$(MAKE) run cmd="bin/rails console"

setup:
	$(MAKE) run cmd="bin/rails dev:cache"
	$(MAKE) run cmd="bin/rails db:setup RAILS_ENV=development"
