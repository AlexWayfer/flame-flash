# Changelog

## master (unreleased)

## 3.0.1.rc1 (2021-04-16)

*   Support Flame 5
*   Forward flashes on redirect
*   Replace `Array` check with `Enumerable`
*   Take flashes only from reserved keys (error, warning, notice) or `flash` key
    Don't extract parameters for controller's path as flashes.
    Reference: <http://guides.rubyonrails.org/action_controller_overview.html#the-flash>
*   Change `FlashArray` to `FlashObject` with `now` and `next` as `FlashArray`
*   Add `FlashArray#delete` method
*   Fix calls of redefined `view` without parameters
*   Make `execute` and methods below `protected`
*   Make `FlashObject` private, test `Flame::Flash` better.
*   Remove `flash.scope` method.
    It was taken not from Rails, but from (abandoned) `sinatra-flash`.
    But we can add it later in more correct way if somebody's needing!
*   Fix requiring by `path` in `Gemfile`
*   Drop Ruby 2.3 and 2.4 support (after Flame)
*   Support Ruby 3.
*   Add MIT license file
*   Add tests, 100% coverage
*   Fix RuboCop warnings, and RuboCop configuration file
    With `rubocop-performance` and `rubocop-rspec`.
*   Improve documentation of methods
*   Add Cirrus CI
*   Add `remark` CI task.
*   Replace `rake` with `toys`.
*   Update development dependencies.
*   Add more meta-information to gem specs.
*   Add "Development", "Contributing" and "License" sections to README.
*   Add CHANGELOG file.
*   Move gem version to a separate file (and constant).

## 2.3.3 (2016-11-16)

*   Flashes extracting fixed for `params` key
*   Migrate from GitLab to GitHub

## 2.3.2 (2016-08-09)

*   Fixed `fix_messages_as_array` method

## 2.3.1 (2016-03-11)

*   Trying to fix messages as `Array`

## 2.3.0 (2016-03-11)

*   Capture `halt` method and take out flash-recording to private method
*   Adding ability to add `Array` as many flashes

## 2.2.0 (2016-02-11)

*   Allowing assign array to `FlashArray`

## 2.1.1 (2016-02-04)

*   Support `String` redirects

## 2.1.0 (2016-02-02)

*   Add flash-options for redirect method of controller

## 2.0.0 (2016-01-29)

*   Support Flame 4.0

## 1.0.1 (2015-12-10)

*   Add `flame` as runtime dependency
*   Update after-hook for Flame 3.3.4

## 1.0.0 (2015-12-07)

*   Initial release.
