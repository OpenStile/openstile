# OpenStile

### Installation

1. Clone the repo
    ```bash
    $ git clone git@github.com:OpenStile/openstile.git
    ```

2. cd to the project directory and bundle install:
    ```bash
    $ cd openstile
    $ bundle install
    ```

3. Run pending migrations:
    ```bash
    $ rake db:migrate RAILS_ENV=development
    ```

4. Installing PhantomJS for testing. You can find instructions [here](https://github.com/teampoltergeist/poltergeist).


### Testing

```bash
$ cd openstile
$ rspec spec/
```
