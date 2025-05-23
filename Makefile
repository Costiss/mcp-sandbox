install:
	@echo "Installing dependencies..."
	@pip install -r requirements.txt

clean_install:
	@echo "Cleaning and installing dependencies..."
	@pip freeze > /tmp/deps.txt
	@pip uninstall -y -r /tmp/deps.txt
	@rm /tmp/deps.txt
	@pip cache purge
	@pip install -r requirements.txt

add:
	@echo "Adding new dependency..."
	@pip install $(word 2,$(MAKECMDGOALS))
	@pip freeze > requirements.txt

remove:
	@echo "Removing dependency..."
	@pip uninstall -y $(word 2,$(MAKECMDGOALS))
	@pip cache purge
	@pip freeze > requirements.txt

lint:
	@echo "Running linters..."
	@basedpyright app

test:
	@echo "Running tests..."
	@python3 -m pytest --disable-warnings -vv

test_cov:
	@echo "Running tests..."
	@python3 -m pytest --disable-warnings --cov=app --cov-branch -vv \
		--cov-fail-under=80 \
		--cov-report xml:coverage.xml \

dev:
	@echo "Running development server..."
	@npx @modelcontextprotocol/inspector &
	@fastapi dev main.py

