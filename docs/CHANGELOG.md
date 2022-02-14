---
layout: default
title: Changelog
---

# Changelog

## main

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
* Remove ArrayConfig - array aliases ObjectConfig
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

* Add inclusion validation to NumberConfig type
* Support ObjectConfigs with nested values
* Support nil control values