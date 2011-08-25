Project-Jumper 0.1
==================

What is Project-Jumper?
-----------------------

Project Jumper is a Vim plugin which creates keyboard shortcuts for editing most common files or exploring most common directories. Currenty works only in Symfony 1.4 projects but I have plans to extend support to Symfony 2 and Rails 3.

Latest version
--------------

Latest version of Vim Project Jumper can be found at https://github.com/zergu/Vim-Project-Jumper

Installation
------------

Unpack all *.vim files and this README into `~/.vim/plugin/project-jumper/` directory. Restart Vim if necessary.

Usage
-----

Default shortucts work from Vim edit mode. To invoke a jump keep `alt` presses and then type `j` and other key depending whare you're trying to jump to.

Shortcuts are working only when current directory (you can check it with `:pwd` command) is from inside a project. Avoid using shortucts elsewhere cause it can do some heavy and unsuccessful file searching.

Default shortcuts
-----------------

Project project related:

* `<M-j><M-t>` Root: Explore project main dir.
* `<M-j><M-m>` Model: Explore lib/model dir.
* `<M-j><M-s>` Schema: Edit config/schema.yml (menu for multiple options).
* `<M-j><M-k>` CSS: Explore web/css dir.
* `<M-j><M-j>` JS: Explore web/js dir.
* `<M-j><M-e>` Test: Explore test dir.
* `<M-j><M-h>` Helper: Explore lib/helper dir.
* `<M-j><M-f>` Form: Explore lib/form dir.
* `<M-j><M-i>` Filter: Explore lib/filter dir.
* `<M-j><M-l>` Lib: Explore lib dir.
* `<M-j><M-q>` SQL: Explore data/sql dir.
* `<M-j><M-x>` Fixtures: Explore data/fixtures dir.

Application related (if your project has more that one application avaiable options are shown):

* `<M-j><M-c>` Controller: Edit actions.class.php when editing or exploring module templates.
* `<M-j><M-v>` View: While cursor is placed on function header tries to edit associaded view. If none could be found, explores views directory.
* `<M-j><M-y>` Layout: Edit $appname/templates/*layout*.php file (supports multiple options).
* `<M-j><M-o>` Modules: Explore $appname/modules dir.
* `<M-j><M-r>` Routing: Edit $appname/config/routing.yml file.
* `<M-j><M-g>` AppConfig: Edit $appname/config/app.yml file.
* `<M-j><M-a>` Application: Explore application maind dir.

Remapping shortucts
-------------------

Just copy mappings from the beginning of `project-jumper.vim` file to your `.vimrc` and modify it.
