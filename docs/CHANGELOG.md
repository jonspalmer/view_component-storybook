---
layout: default
title: Changelog
---

# Changelog

## main

## 0.12.1

Last 0.x release
* Prepare for renaming to `view_component-storybook` to align with Rubygems naming conventions and simpler installation.

## 0.12.0

* Allow configuration of story titles via new `stories_title_generator` configuration lambda
* Added control descriptions
* Fixed bug with autoload paths
* Fixed Documentation typos

## 0.11.1

* Fix for stories_route by when using deprecated `require "view_component/storybook/engine"`

## 0.11.0

* Add support for dry-initializer
* Validate Slots

## 0.10.1

* Allow Object Controls with arrays of simple values

## 0.10.0

* New Stories API
  * `title` - custom stories title 
  * `constructor` - component args
  * `slot` - args and content for slots
  * component and slot content accepts controls
* New Controls
  * Custom Control
  * Klazz Control
* Deprecated Controls DSL
* Add support for Object Controls with array values
* Remove ArrayConfig - array aliases Object
* Updated Options Control to match Storybook 6.2 syntax
  * `options` as array
  * add `labels` option
  * deprecate `options` as Hash
  * multi select types accept and return array values
* Improved validation errors with i18n support
* Add `stories_route` config to configure stories endpoint
* Jekyll docs

## 0.9.0

* Allow view helpers in content blocks

## 0.8.0

* Add support for components with keyword argument constructors

## 0.7.0

* Add inclusion validation to Number type
* Support Objects with nested values
* Support nil control values