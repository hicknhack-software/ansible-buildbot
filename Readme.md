hicknhack-software.buildbot
===========================

A set of roles that help to deploy the buildbot integration setups.

Requirements
------------

* Ubuntu 14.04 (Trusty)
* Windows 2012R2

Content Roles
-------------

* **master/install-nine** install the buildbot from the git master branch
* **master/create** create a buildbot master in a directory
* **master/inplace-config** install and configure the buildbot addon for inplace build configurations
* **master/start** start the buildbot master with custom configuration
* **master/start-inplace** start the buildbot master with the inplace configuration
* **master/stop** stop the buildbot master
* **project/add** add a project to the inplace buildbot master
* **project/kill** remove a project from the inplace buildbot master
* **worker/create** install a worker and add it to the buildbot master
* **worker/start** start a worker
* **winworker/create** install a windows worker and add it to the buildbot master
* **winworker/start** start a windows worker

Dependencies
------------

no other roles currently

You may want to use our [vagrant-ansible-remote](https://github.com/dresden-weekly/vagrant-ansible-remote) for testing and deploying

Example Playbook
----------------

See our example: https://github.com/hicknhack-software/ansible-buildbot-example

Changelog
---------

**0.1** (upcoming)

* Essentials to configure and run Buildbot installation
* Buildbot master with inplace configuration
* Buildbot worker for Windows and Ubuntu
* Git support for projects

Roadmap
-------

* SCM
  * ☐ Git hosted projects
  * ☐ SVN hosted projects
* Buildbot worker on
  * ☐ MacOS
  * ☐ CentOS
* Your ideas

License
-------

The MIT License (MIT)

Copyright (c) 2015 HicknHack Software GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
