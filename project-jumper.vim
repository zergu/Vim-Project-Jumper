" Exit when your app has already been loaded
if exists("g:loaded_Jumper")
  finish
endif
let g:loaded_Jumper = 1

" Key bindings: MVC
map <C-M-m> :call JumperJump("model")<CR>
map <C-M-v> :call JumperJump("view")<CR>
map <C-M-c> :call JumperJump("controller")<CR>

" Key bindings: project
map <C-M-t> :call JumperJump("root")<CR>
map <C-M-s> :call JumperJump("schema")<CR>
map <C-M-e> :call JumperJump("test")<CR>
map <C-M-h> :call JumperJump("helper")<CR>
map <C-M-f> :call JumperJump("form")<CR>
map <C-M-i> :call JumperJump("filter")<CR>
map <C-M-l> :call JumperJump("lib")<CR>
map <C-M-q> :call JumperJump("sql")<CR>
map <C-M-x> :call JumperJump("fixtures")<CR>
map <C-M-u> :call JumperJump("parent")<CR>
map <C-M-p> :call JumperJump("plugins")<CR>

" Key bindings: applications
map <C-M-a> :call JumperJump("application")<CR>
map <C-M-y> :call JumperJump("layout")<CR>
map <C-M-o> :call JumperJump("modules")<CR>
map <C-M-r> :call JumperJump("routing")<CR>
map <C-M-g> :call JumperJump("appconfig")<CR>
map <C-M-a> :call JumperJump("application")<CR>
map <M-1> :call JumperJump("application_num", 1)<CR>
map <M-2> :call JumperJump("application_num", 2)<CR>
map <M-3> :call JumperJump("application_num", 3)<CR>
map <M-4> :call JumperJump("application_num", 4)<CR>
map <M-5> :call JumperJump("application_num", 5)<CR>
map <M-6> :call JumperJump("application_num", 6)<CR>
map <M-7> :call JumperJump("application_num", 7)<CR>
map <M-8> :call JumperJump("application_num", 8)<CR>
map <M-9> :call JumperJump("application_num", 9)<CR>

" Key bindings: frontend assets
map <C-M-j> :call JumperJump("js")<CR>
map <C-M-k> :call JumperJump("css")<CR>

" Key bindings: Symfony2 specific
map <C-M-b> :call JumperJump("bundles")<CR>
map <C-M-n> :call JumperJump("vendor")<CR>

" JUMP!
function! JumperJump(target, ...)
	try
		if !exists("w:maindir")
			" Is this Symfony 1 project?
			let w:maindir	= s:ProjectFinder("symfony")
			let w:type		= "sf1"
			if w:maindir == ""
				" If not, is it Symfony 2 project?
				let w:maindir	= s:ProjectFinder("symfony2")
				let w:type		= "sf2"

				" Let user know if it couldn't be found
				if w:maindir == ""
					throw "It doesn't look like symfony project, exiting..."
				endif
			endif
		endif

		" Symfony 1: Handle different targets to jump to
		if w:type == "sf1"
			" Model - just explore
			if a:target == "model"
				execute "Explore ".w:maindir."lib/model"
			" CSS - explore dir
			elseif a:target == "css"
				execute "Explore ".w:maindir."web/css"
			" Javascripts - explore dir
			elseif a:target == "js"
				execute "Explore ".w:maindir."web/js"
			" Tests - explore dir
			elseif a:target == "test"
				execute "Explore ".w:maindir."test"
			" Helpers - explore dir
			elseif a:target == "helper"
				execute "Explore ".w:maindir."lib/helper"
			" Forms - explore dir
			elseif a:target == "form"
				execute "Explore ".w:maindir."lib/form"
			" Filters - explore dir
			elseif a:target == "filter"
				execute "Explore ".w:maindir."lib/filter"
			" Libs - explore dir
			elseif a:target == "lib"
				execute "Explore ".w:maindir."lib"
			" SQL - explore dir
			elseif a:target == "sql"
				execute "Explore ".w:maindir."data/sql"
			" Fixtures - explore dir
			elseif a:target == "fixtures"
				execute "Explore ".w:maindir."data/fixtures"
			" Plugins - explore dir
			elseif a:target == "plugins"
				execute "Explore ".w:maindir."plugins"
			" Main dir - explore dir
			elseif a:target == "root"
				execute "Explore ".w:maindir
			" Schema - if there's only one, edit it, if more, show menu
			elseif a:target == "schema"
				let l:results = split(system("find ".w:maindir."config -name \"*schema.yml\" | grep -v .svn"))
				execute "edit ".l:results[s:MultipleChoice(l:results)]
			" Modules - explore
			elseif a:target == "modules"
				let l:results = s:AppFinder(w:maindir)
				execute "Explore ".l:results[s:MultipleChoice(l:results)]."/modules"
			" Layout - explore
			elseif a:target == "layout"
				let l:results = s:AppFinder(w:maindir)
				let l:results = split(system("find ".l:results[s:MultipleChoice(l:results)]."/templates -name \"*layout*.php\" | grep -v .svn"))
				execute "edit ".l:results[s:MultipleChoice(l:results)]
			" Routing - edit
			elseif a:target == "routing"
				let l:results = s:AppFinder(w:maindir)
				execute "edit ".l:results[s:MultipleChoice(l:results)]."/config/routing.yml"
			" App main dir - explore
			elseif a:target == "application"
				let l:results = s:AppFinder(w:maindir)
				execute "Explore ".l:results[s:MultipleChoice(l:results)]
			" App main dir by number - explore (numbers assigned by
			" alphabetical order)
			elseif a:target == "application_num"
				let l:results = s:AppFinder(w:maindir)
				execute "Explore ".l:results[a:1-1]
			" App config - edit
			elseif a:target == "appconfig"
				let l:results = s:AppFinder(w:maindir)
				execute "edit ".l:results[s:MultipleChoice(l:results)]."/config/app.yml"
			" Parent class - edit
			elseif a:target == "parent"
				throw "Not implemented yet"
				let l:parent_name = system("grep -o 'extends \\w\\+' ".expand("%:p")." | sed 's/extends //' | sed 's/\\^\\@//")

				throw "find ".w:maindir." -type f -name \"".l:parent_name.".php\""
				if l:parent_name
					let l:results = split(system("find ".w:maindir." -type f -name \"".l:parent_name.".php\""))
					execute "edit ".l:results[s:MultipleChoice(l:results)]
				endif
			" Jump to controller from views (magical)
			elseif a:target == "controller"
				let l:currdir = expand("%:p:h")
				if matchend(l:currdir, "templates") != -1 " Check if we're in templates dir
					silent execute "edit ".l:currdir."/../actions/actions.class.php"
				endif
			" Jump to views form actions (magical), jumping from function
			" header tries to go to corresponding view
			elseif a:target == "view"
				let l:currdir = expand("%:p:h")
				if matchend(l:currdir, "actions") != -1 " Check if we're in actions dir
					let l:actionname = matchlist(getline('.'), 'execute\(.*\) \?(')
					if len(l:actionname) > 1
						let l:target_file = l:currdir."/../templates/".tolower(substitute(l:actionname[1], " ", "", ""))."Success.php"
					endif

					if len(l:actionname) && filereadable(l:target_file)
						execute "edit ".l:target_file
					else
						silent execute "Explore ".l:currdir."/../templates"
					endif
				endif
			else
				throw "Unrecognized target ".a:target
			endif

		" Symfony 2: Handle different targets to jump to
		elseif w:type == "sf2"
			" Projects main dir - explore
			if a:target == "root"
				execute "Explore ".w:maindir
			" App config dir - explore
			elseif a:target == "appconfig"
				execute "Explore ".w:maindir."/app/config"
			" Base layout - edit
			elseif a:target == "layout"
				execute "edit ".w:maindir."/app/Resources/views/base.html.twig"
			" Bundles - explore
			elseif a:target == "bundles"
				let l:results = s:BundleFinder(w:maindir)
				execute "Explore ".l:results[s:MultipleChoice(l:results)]."/"
			" Vendor - explore
			elseif a:target == "vendor"
				let l:results = split(system("find ".w:maindir."vendor -mindepth 1 -maxdepth 1 -type d | grep -v .svn "))
				execute "Explore ".l:results[s:MultipleChoice(l:results)]."/"
			" Controllers in AcmeAppBundle
			elseif a:target == "controller"
				execute "Explore ".w:maindir."/src/Acme/AppBundle/Controller"
			" Model in AcmeAppBundle
			elseif a:target == "model"
				if isdirectory(w:maindir."/src/Acme/AppBundle/Model")
					execute "Explore ".w:maindir."/src/Acme/AppBundle/Model"
				else
					execute "Explore ".w:maindir."/src/Acme/AppBundle/Entity"
				endif
			" Views in AcmeAppBundle
			elseif a:target == "view"
				execute "Explore ".w:maindir."/src/Acme/AppBundle/Resources/views"
			" Form in AcmeAppBundle
			elseif a:target == "form"
				execute "Explore ".w:maindir."/src/Acme/AppBundle/Form/Type"
			" Routing - edit
			elseif a:target == "routing"
				let l:results = s:BundleFinder(w:maindir)
				execute "edit ".w:maindir."/src/Acme/AppBundle/Resources/config/routing.yml"
			" Schema - edit
			elseif a:target == "schema"
				let l:results = s:BundleFinder(w:maindir)
				execute "edit ".w:maindir."/src/Acme/AppBundle/Resources/config/schema.xml"
			" SQL - explore base and fixtures
			elseif a:target == "sql"
				let l:results = s:BundleFinder(w:maindir)
				execute "Explore ".w:maindir."/app/propel/"
			" App main dir - explore
			elseif a:target == "application"
				execute "Explore ".w:maindir."/app"
			" Bundle main dir by number - explore (numbers assigned by
			" alphabetical order)
			elseif a:target == "application_num"
				let l:results = s:BundleFinder(w:maindir)
				execute "Explore ".l:results[a:1-1]
			else
				throw "Unrecognized target ".a:target
			endif
		endif

	catch /.*/
		echom v:exception
	endtry
endfunction


"
" Find project main dir
"
function s:ProjectFinder(name)
	" First check current directory
	let l:result = findfile(a:name, getcwd())

	" If file couldn't be found, check upwards
	if l:result == ""
		let l:result = findfile(a:name, ".;")
		" If file is found, get it's directory
		if l:result != ""
			let l:result = substitute(l:result,a:name,"","")
		endif
	else
		let l:result = getcwd()."/"
	endif

	return l:result
endfunction

"
" Helper for finding application names in Symfony1
"
function s:AppFinder(maindir)
	return split(system("find ".a:maindir."apps -type d -mindepth 1 -maxdepth 1 | egrep -v '.svn|.git' | sort"))
endfunction

"
" Helper for finding bundle names in Symfony2
"
function s:BundleFinder(maindir)
	return split(system("find ".a:maindir."src/Acme/ -mindepth 1 -maxdepth 1 -type d | grep -v .svn | sort"))
endfunction

"
" Helper for multiple targets
"
function s:MultipleChoice(results)
	let num = len(a:results)
	if num < 1
		throw "Noting found"
	elseif num == 1
		return 0
	else
		" Add labels for inputlist
		let l:results_labeled = []
		let i = 1
		for item in a:results
			let l:results_labeled += [i.". ".item]
			let i += 1
		endfor
		let l:choice = inputlist(l:results_labeled) - 1 " -1 cause labels starts with 1 and list starts with 0
		" Avoid bad choices
		if l:choice + 1 > num
			let l:choice = num - 1
		endif
	endif
	return l:choice
endfunction
