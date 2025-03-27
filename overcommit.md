## Overcommit Configuration

This is for analysing code with mallow standards while commiting changes. It automatically run following checks for you uncommitted changes.

### To run the following to set ruby version

`rbenv local <ruby version>`

### To run the following things to install needed gems.

`gem install overcommit`

`gem install brakeman`

`gem install bundler-audit`

`gem install rubocop`

### To run following things to setup git pre-hooks after bundle install.

initiate the overcommit configuration

`overcommit --install`