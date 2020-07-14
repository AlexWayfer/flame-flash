# Changelog

## master (unreleased)

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
*   Fix requiring by `path` in `Gemfile`
*   Drop Ruby 2.3 and 2.4 support (after Flame)
*   Add MIT license file
*   Add tests, 100% coverage
*   Fix RuboCop warnings, and RuboCop configuration file
    With `rubocop-performance` and `rubocop-rspec`.
*   Improve documentation of methods
*   Add Cirrus CI

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
