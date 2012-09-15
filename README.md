Project-Jumper
==================

What is Project-Jumper?
-----------------------

Project Jumper is a Vim plugin which creates keyboard shortcuts for editing most common files or exploring most common directories
in Symfony 1 and 2 (work in progress) frameworks.

Latest version
--------------

Latest version of Vim Project Jumper can be found at https://github.com/zergu/Vim-Project-Jumper

Installation
------------

Unpack all *.vim files and this README into `~/.vim/plugin/project-jumper/` directory. Restart Vim if necessary.

**Important notice for Symfony 2 users:** In order Project-Jumper to work you need to create a `symfony2` file in your project main directory.
It may be empty but it's better to use is as wrapper for app/console with content like this (also executable permissions need to be set for convenient
use):
`php app/console $@`

Usage
-----

Default shortcuts work from Vim edit mode. To invoke a jump, keep `ctrl` and `alt` pressed and then type a key depending whare you're trying to jump to.

Project is determined during first jump and valid until Vim window is closed.

Default shortcuts
-----------------

### Symfony 1.4 ###

Project related:

* `<C-M-t>` Root: Explore project main dir.
* `<C-M-m>` Model: Explore lib/model dir.
* `<C-M-s>` Schema: Edit config/schema.yml (menu for multiple options).
* `<C-M-k>` CSS: Explore web/css dir.
* `<C-M-j>` JS: Explore web/js dir.
* `<C-M-e>` Test: Explore test dir.
* `<C-M-h>` Helper: Explore lib/helper dir.
* `<C-M-f>` Form: Explore lib/form dir.
* `<C-M-i>` Filter: Explore lib/filter dir.
* `<C-M-l>` Lib: Explore lib dir.
* `<C-M-q>` SQL: Explore data/sql dir.
* `<C-M-x>` Fixtures: Explore data/fixtures dir.
* `<C-M-p>` Plugins: Explore plugins dir.

Application related (if your project has more that one application available options are shown):

* `<C-M-c>` Controller: Edit actions.class.php when editing or exploring module templates.
* `<C-M-v>` View: While cursor is placed on function header tries to edit associaded view. If none could be found, explores views directory.
* `<C-M-y>` Layout: Edit $appname/templates/*layout*.php file (supports multiple options).
* `<C-M-o>` Modules: Explore $appname/modules dir.
* `<C-M-r>` Routing: Edit $appname/config/routing.yml file.
* `<C-M-g>` AppConfig: Edit $appname/config/app.yml file.
* `<C-M-a>` Application: Explore application main dir.

Applications by alphabetical order

* `<M-1>` First app
* `<M-2>` Second app
* `<M-3>` Third app
* …
* `<M-9>` Ninth app

### Symfony 2 ###

Project related:

* `<C-M-t>` Root: Explore project main dir.
* `<C-M-g>` AppConfig: Explore app/config/ dir.
* `<C-M-b>` Bundles: Explore src/\*/ dir.
* `<C-M-n>` Vendor: Explore vendor/ dir.

Remapping shortucts
-------------------

Just copy mappings from the beginning of `project-jumper.vim` file to your `.vimrc` and modify it.
