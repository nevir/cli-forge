CLI Forge [![Gem Version](https://badge.fury.io/rb/cli-forge.png)](https://rubygems.org/gems/cli-forge) [![Build Status](https://secure.travis-ci.org/nevir/cli-forge.png?branch=master)](http://travis-ci.org/nevir/cli-forge) [![Coverage Status](https://coveralls.io/repos/nevir/cli-forge/badge.png?branch=master)](https://coveralls.io/r/nevir/cli-forge) [![Code Climate](https://codeclimate.com/github/nevir/cli-forge.png)](https://codeclimate.com/github/nevir/cli-forge) [![Dependency Status](https://gemnasium.com/nevir/cli-forge.png)](https://gemnasium.com/nevir/cli-forge)
=========

Beat your CLI tool suites into submission!

* Create CLI tools that are easily extended (`git style args` -> `git-style args`)

* A help system that is friendly to you _and_ your users.

* That warm fuzzy feeling of being able to support plugin commands written in
  any language.


Ok... How Do I?
===============

Let's start with the most basic example:

```ruby
#!/usr/bin/env ruby
require "cli-forge"

CLIForge.start
```


License
=======

[CLI Forge is MIT Licensed](MIT-LICENSE.md).
