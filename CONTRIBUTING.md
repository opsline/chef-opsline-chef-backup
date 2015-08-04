# Contributing to OpsLine Cookbooks

We are excited you want to contribute improvements to OpsLine Cookbooks!

## Quick-contribute

* Create a github issue
* Fork the repository, create a topic branch and link a pull request
* Implement tests and make sure all tests pass

We regularly review contributions and will get back to you if we have
any suggestions or concerns.


## Cookbook Contribution Do's and Don't's

Please do include tests for your contribution (KitchenCI + serverspec).

Not all platforms that a cookbook supports may be supported by Test
Kitchen. Please provide evidence of testing your contribution if it
isn't trivial so we don't have to duplicate effort in testing.

Please do indicate new platform (families) or platform versions in the
commit message, and update the relevant ticket.

Please do ensure that your changes do not break or modify behavior for
other platforms supported by the cookbook.

Please do not modify the version number in the metadata.rb.

Please do not update the CHANGELOG.md for a new version. Not all
changes to a cookbook may be merged and released in the same versions.
