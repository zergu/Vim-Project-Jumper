" Exit when your app has already been loaded
if exists("g:loaded_Jumper")
  finish
endif
let g:loaded_Jumper = 1 " Version numbrer

" Key bindings
map <C-j><C-m> :call JumperJump("model")<CR>
map <C-j><C-s> :call JumperJump("schema")<CR>
map <C-j><C-y> :call JumperJump("css")<CR>
map <C-j><C-j> :call JumperJump("js")<CR>
map <C-j><C-t> :call JumperJump("test")<CR>
map <C-j><C-h> :call JumperJump("helper")<CR>
map <C-j><C-f> :call JumperJump("form")<CR>
map <C-j><C-i> :call JumperJump("filter")<CR>
map <C-j><C-l> :call JumperJump("lib")<CR>
map <C-j><C-q> :call JumperJump("sql")<CR>
map <C-j><C-x> :call JumperJump("fixtures")<CR>
map <C-j><C-u> :call JumperJump("layout")<CR>
map <C-j><C-o> :call JumperJump("modules")<CR>
map <C-j><C-r> :call JumperJump("routing")<CR>
map <C-j><C-g> :call JumperJump("appconfig")<CR>
map <C-j><C-a> :call JumperJump("action")<CR>
map <C-j><C-v> :call JumperJump("view")<CR>

" JUMP!
function! JumperJump(target)
	try
		" Find project's main directory by locating 'symfony' file
		let l:maindir = findfile("symfony", ".;")
		if l:maindir == "symfony" " File found in current dir and not pull path is returned
			let l:maindir = getcwd()."/"
		else
			let l:maindir = substitute(l:maindir,"symfony","","")
		endif

		" Let user know if it couldn't be found
		if l:maindir == ""
			throw "It doesn't look like symfony project, exiting..."
		" Handle different targets to jump to
		else
			" Model - just explore
			if a:target == "model"
				execute "Explore ".l:maindir."lib/model"
			" CSS - explore dir
			elseif a:target == "css"
				execute "Explore ".l:maindir."web/css"
			" Javascripts - explore dir
			elseif a:target == "js"
				execute "Explore ".l:maindir."web/js"
			" Tests - explore dir
			elseif a:target == "test"
				execute "Explore ".l:maindir."test"
			" Helpers - explore dir
			elseif a:target == "helper"
				execute "Explore ".l:maindir."lib/helper"
			" Forms - explore dir
			elseif a:target == "form"
				execute "Explore ".l:maindir."lib/form"
			" Filters - explore dir
			elseif a:target == "filter"
				execute "Explore ".l:maindir."lib/filter"
			" Libs - explore dir
			elseif a:target == "lib"
				execute "Explore ".l:maindir."lib"
			" SQL - explore dir
			elseif a:target == "sql"
				execute "Explore ".l:maindir."data/sql"
			" Fixtures - explore dir
			elseif a:target == "fixtures"
				execute "Explore ".l:maindir."data/fixtures"
			" Main dir - explore dir
			elseif a:target == "root"
				execute "Explore ".l:maindir
			" Schema - if there's only one, edit it, if more, show menu
			elseif a:target == "schema"
				let l:results = split(system("find ".l:maindir."config -name \"*schema.yml\" | grep -v .svn"))
				execute "edit ".l:results[s:MultipleChoice(l:results)]
			" Modules - explore
			elseif a:target == "modules"
				let l:results = split(system("find ".l:maindir."apps -type d -mindepth 1 -maxdepth 1 | grep -v .svn"))
				execute "Explore ".l:results[s:MultipleChoice(l:results)]."/modules"
			" Layout - explore
			elseif a:target == "layout"
				let l:results = split(system("find ".l:maindir."apps -type d -mindepth 1 -maxdepth 1 | grep -v .svn"))
				let l:results = split(system("find ".l:results[s:MultipleChoice(l:results)]."/templates -name \"*layout*.php\" | grep -v .svn"))
				execute "edit ".l:results[s:MultipleChoice(l:results)]
			" Routing - edit
			elseif a:target == "routing"
				let l:results = split(system("find ".l:maindir."apps -type d -mindepth 1 -maxdepth 1 | grep -v .svn"))
				execute "edit ".l:results[s:MultipleChoice(l:results)]."/config/routing.yml"
			" App config - edit
			elseif a:target == "appconfig"
				let l:results = split(system("find ".l:maindir."apps -type d -mindepth 1 -maxdepth 1 | grep -v .svn"))
				execute "edit ".l:results[s:MultipleChoice(l:results)]."/config/app.yml"
			" Jump to actions from views (magical)
			elseif a:target == "action"
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
				throw "Unrecognized target" a:target 
			endif
		endif
	catch /.*/
		echom v:exception
	endtry
endfunction

" Helper for multiple targets
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
