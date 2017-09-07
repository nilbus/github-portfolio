[![Circle
CI](https://circleci.com/gh/nilbus/github-portfolio.svg?style=shield)](https://circleci.com/gh/nilbus/github-portfolio)
[![Code
Climate](https://codeclimate.com/github/nilbus/github-portfolio/badges/gpa.svg)](https://codeclimate.com/github/nilbus/github-portfolio)

GitHub Portfolio
================

Generate a portfolio for your GitHub repository.

See the [wiki](https://github.com/nilbus/github-portfolio/wiki) for an overview of
the implementation.

Selecting Repositories to Showcase
----------------------------------

github-portfolio will only show projects that you have self-starred.

1. Starring a repository that you can push to will display it as a primary repository.
2. Starring a your fork of another repostiory will show the parent repository as a
   project that you have contributed to.

Viewing Your Portfolio
----------------------

* Visit /<your-github-username> to view your portfolo
* Visit /<your-github-username>/reload to reload your portfolo

Installation
============

This is a standard Rails 4 application.

After bundler installs gems, these initial setup steps will get the app running:

* Create a personal access token with the public\_repo permission at
  https://github.com/settings/tokens.

* Create `config/secrets.yml` from `config/secrets.yml.example`, and insert your
  GitHub access token.

* Migrate the database

        rake db:migrate

* Install memcached. To use memcached in development/test environments, set
  environment variable

        MEMCACHED_IN_DEVELOPMENT=true

* Run the rails server

        rails server

* (Optional) For fast page loads, [configure your web server][1] to use the page
  caches that the app generates in `public/page_cache/`.
[1]: https://github.com/rails/actionpack-page_caching/issues/27#issuecomment-110550147

Customizing
===========

* To configure the root route `/` to display a particular portfolio, set the
  environment variable:

    PORTFOLIO=your-github-login

* Modify the `hue` value in `secrets.yml` to a color of your choice.
  You can also use the URL parameter `?hue=123` to experiment with hue colors.
  Restart the rails server if it is running.

* Use the `rails console` to customize the header text:

    ```ruby
    Header.find_or_create_by(github_username: 'your-github-login') do |header|
      header.title = 'Large Heading Text',
      header.tagline = 'Tagline text',
      header.intro = "Some text.\nFeel free to use more lines."
    end
    ```

License
=======

This github-portfolio application is Copyright 2015 Edward Anderson,
and is distributed under the GNU Affero General Public License.

You may use this code for free, but you are required to offer the source code
for your version to your users. See LICENSE for details.
